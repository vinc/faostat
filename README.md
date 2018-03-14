# FAOSTAT: CSV to Markdown

## Usage

    $ bundle exec ruby faostat.rb examples/crops.yml

## Examples

### World Land Use

Source: FAOSTAT 2013

Units: million hectares

|                                     |     Area |
| ----------------------------------- | --------:|
| Land                                | 13021.25 |
| .. Crops                            |  1571.97 |
| .. Pastures                         |  3309.64 |
| .. Forests                          |  4005.75 |
| .. Other                            |  4133.88 |

### World Crops

Source: FAOSTAT 2013

Units: million tonnes, million hectares

|                            |    Prod |    Area |
| -------------------------- | -------:| -------:|
| Crops                      | 8538.44 | 1321.62 |
| .. Cereals                 | 2768.02 |  722.32 |
| .. Roots                   |  817.52 |   61.46 |
| .. Pulses                  |   77.97 |   80.01 |
| .. Vegetables              |  997.84 |   54.52 |
| .. Fruits                  |  823.66 |   63.56 |
| .. Nuts                    |   14.93 |   11.13 |
| .. Sugar Crops             | 2150.31 |   31.39 |
| .. Oil Crops               |  809.58 |  261.92 |
| .. Fibres                  |   78.59 |   35.32 |

### World Food Balance

Source: FAOSTAT 2013

Units: million tonnes

|                            |    Prod |  Supply |    Food |    Feed |    Seed | Process |   Waste |   Other |
| ---------------------------| -------:| -------:| -------:| -------:| -------:| -------:| -------:| -------:| 
| Crops                      | 8045.41 | 7901.84 | 3217.34 | 1196.07 |  148.90 | 2165.22 |  424.88 |  757.32 |
| .. Cereals                 | 2523.35 | 2407.01 | 1029.02 |  873.55 |   68.55 |   94.58 |  107.12 |  234.80 |
| .. Roots                   |  811.32 |  815.70 |  443.35 |  175.29 |   35.12 |   15.44 |   82.45 |   64.23 |
| .. Pulses                  |   82.67 |   81.50 |   59.20 |   13.19 |    4.10 |    0.00 |    3.85 |    1.27 |
| .. Vegetables              | 1129.61 | 1124.93 |  982.97 |   51.71 |    0.11 |    0.24 |   89.72 |    0.58 |
| .. Fruits                  |  662.13 |  661.60 |  544.88 |    2.45 |    0.00 |   53.30 |   60.36 |    1.72 |
| .. Nuts                    |   16.93 |   16.80 |   16.41 |    0.00 |    0.00 |    0.00 |    0.49 |    0.07 |
| .. Sugar Crops             | 2126.84 | 2128.23 |   32.25 |   39.74 |   29.36 | 1593.75 |   69.97 |  363.17 |
| .. Oil Crops               |  526.03 |  503.15 |   29.67 |   39.44 |   11.64 |  407.55 |   10.42 |    8.82 |
| .. Vegetable Oils          |  166.54 |  162.92 |   79.59 |    0.71 |    0.00 |    0.35 |    0.49 |   82.67 |

### World Population

Source: FAOSTAT 2013

Units: million people

|                            |     Pop |
| ---------------------------| -------:|
| Population                 | 7213.43 |
| .. Humans                  | 7213.43 |

### World Livestock

Source: FAOSTAT 2013

Units: million heads

|                           |      Pop |
| ------------------------- | --------:|
| Livestock                 | 28156.90 |
| .. Animals live nes       |     6.23 |
| .. Asses                  |    42.51 |
| .. Beehives               |    84.90 |
| .. Buffaloes              |   193.07 |
| .. Camelids, other        |     8.84 |
| .. Camels                 |    27.30 |
| .. Cattle                 |  1434.40 |
| .. Chickens               | 20955.42 |
| .. Ducks                  |  1111.52 |
| .. Geese and guinea fowls |   348.28 |
| .. Goats                  |   954.72 |
| .. Horses                 |    58.62 |
| .. Mules                  |    10.22 |
| .. Pigeons, other birds   |    32.35 |
| .. Pigs                   |   976.34 |
| .. Rabbits and hares      |   309.67 |
| .. Rodents, other         |    18.92 |
| .. Sheep                  |  1132.72 |
| .. Turkeys                |   450.87 |
