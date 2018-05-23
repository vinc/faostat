require "csv"
require "rake"
require "ruby-progressbar"
require "yaml"

class Faostat
  def initialize(yml_file)
    config = YAML.load_file(yml_file)

    @title = config["Title"]
    @year = config["Year"]
    @unit = config["Unit"] || 1_000_000
    @areas = config["Areas"]
    @elements = config["Elements"]

    @items = config["Items"]

    @display_max_level = config.dig("Display", "MaxLevel") || 99
    @display_format_item = config.dig("Display", "Format", "Item") || "%-37s"
    @display_format_element = config.dig("Display", "Format", "Element") || "%7.2f"
    @display_units = config.dig("Display", "Units") || []
    @display_elements = config.dig("Display", "Elements") || config["Elements"]
    @display_elements = @display_elements.keys if @display_elements.is_a? Hash

    csv_file = yml_file.ext(".csv")
    download_csv(config["URL"], csv_file) unless File.exist?(csv_file)
    process_csv(csv_file)
  end

  def display
    printf("# #{@title}\n")
    printf("\n")
    printf("Source: FAOSTAT #{@year}\n")
    printf("\n")
    printf("Units: #{@display_units.join(', ')}\n")

    @areas.each do |area|
      @items.each do |group, group_items|
        compute_group_items(area, group, group_items)
      end

      printf("\n")
      printf("\n")
      printf("## %s\n", area)
      printf("\n")

      # Print headers
      kw = display_format_item_length
      vw = display_format_element_length
      print_border
      printf("    | #{' ' * kw} |")
      @display_elements.each do |col|
        printf(" %#{vw}s |", col)
      end
      printf("\n")
      print_border

      next if @data[area].nil?

      @items.each do |group, group_items|
        print_group(area, group, group_items, 0)
      end

      print_border
    end
  end

  private

  def download_csv(url, csv_file)
    $stderr.write("Downloading '#{url}' ...\n")
    system("wget", "-qc", url)

    zip_file = File.basename(url)
    $stderr.write("Extracting '#{zip_file}' ...\n")
    system("unzip", "-q", zip_file)

    FileUtils.rm(zip_file)
    FileUtils.mv(zip_file.ext(".csv"), csv_file)
  end

  def process_csv(csv_file)
    $stderr.write("Reading '#{csv_file}' ...\n")
    @data = {}

    progressbar = ProgressBar.create(
      output: $stderr,
      total: File.open(csv_file).readlines.count
    )

    items = deep_values(@items).flatten.uniq
    elements = deep_values(@elements).flatten.uniq

    CSV.foreach(csv_file, headers: true, encoding: "iso-8859-1") do |row|
      progressbar.increment
      area = row["Area"]
      # break if area[0..1] > "Ch"
      next unless @areas.include? area

      item = row["Item"]
      next unless items.include? item

      element = row["Element"]
      next unless elements.flatten.uniq.include? element

      unit = row["Unit"]
      value = row["Y#{@year}"] || 0

      # printf("%s %s: %.2f %s\n", area, item, value, unit)

      @data[area] ||= {}
      @data[area][item] ||= {}
      @data[area][item][element] =
        case unit
        when /1000 /
          value.to_f * 1000.0
        else
          value.to_f
        end
    end
    progressbar.finish
    $stderr.write("\n")
  end

  def compute_group(area, group, group_items)
    @data[area][group] ||= {}

    group_items.each do |item|
      @data[area][item] ||= {}
      case @elements
      when Array
        @elements.each do |element|
          @data[area][group][element] ||= 0
          @data[area][group][element] += @data[area][item][element] || 0
        end
      when Hash
        @elements.each do |name, elements|
          @data[area][group][name] ||= 0
          elements.each do |element|
            @data[area][group][element] ||= 0
            @data[area][group][element] += @data[area][item][element] || 0
            @data[area][group][name] += @data[area][item][element] || 0 if name != element
          end
        end
      end
    end
  end

  def compute_group_items(area, group, group_items)
    if group_items.is_a? Hash
      group_items.each do |subgroup, subgroup_items|
        compute_group_items(area, subgroup, subgroup_items)
      end
      group_items = group_items.keys
    end
    compute_group(area, group, group_items)
  end

  def print_group(area, group, group_items, level)
    print_item(area, group, level)

    case group_items
    when Hash
      group_items.each do |subgroup, subgroup_items|
        print_group(area, subgroup, subgroup_items, level + 1)
      end
    else
      group_items.each do |item|
        print_item(area, item, level + 1)
      end
    end
  end

  def print_item(area, item, level)
    return unless level < @display_max_level
    dots = ([".."] * level).join(".")
    printf("    | #{@display_format_item} |", [dots, item].reject(&:empty?).join(" "))

    @data[area][item] ||= {} # FIXME
    elements = @elements.is_a?(Hash) ? @elements.keys : @elements
    elements.each do |element|
      value = @data[area][item][element]
      if value
        printf(" #{@display_format_element} |", value / @unit)
      else
        vw = display_format_element_length
        printf(" #{' ' * vw} |")
      end
    end
    printf("\n")
  end

  def display_format_item_length
    sprintf(@display_format_item, "").length
  end

  def display_format_element_length
    sprintf(@display_format_element, 0.0).length
  end

  def print_border
    kw = display_format_item_length
    vw = display_format_element_length
    printf("    +-#{(['-' * kw] + ['-' * vw] * @elements.count).join('-+-')}-+\n")
  end

  def deep_values(hash)
    return hash unless hash.is_a? Hash
    hash.values.map do |value|
      case value
      when Hash
        deep_values(value)
      else
        value
      end
    end
  end
end

if ARGV.empty?
  puts "Usage: faostat config.yml"
else
  yml_file = ARGV.shift
  Faostat.new(yml_file).display
end
