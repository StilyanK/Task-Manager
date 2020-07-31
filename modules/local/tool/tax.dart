List clientClass = ['Retail Class', 'Business Class', 'Medical Class'];

List productClass = ['VAT Class'];

List countryTax = [
  ['st', 'Austria 20% (standard)', '{"1": "ДДС", "2": "VAT"}', 20, 13],
  [
    '',
    'Austria 10% (reduced: food / books / pharma / hotels)',
    '{"1": "ДДС", "2": "VAT"}',
    10,
    13
  ],
  ['st', 'Belgium 21% (standard)', '{"1": "ДДС", "2": "VAT"}', 21, 21],
  [
    '',
    'Belgium 12% (reduced: restaurants)',
    '{"1": "ДДС", "2": "VAT"}',
    12,
    21
  ],
  [
    'm',
    'Belgium 6% (reduced: food / books/ pharma / medical / hotels)',
    '{"1": "ДДС", "2": "VAT"}',
    6,
    21
  ],
  ['st', 'Bulgaria 20% (standard)', '{"1": "ДДС", "2": "VAT"}', 20, 23],
  ['', 'Bulgaria 9% (reduced: hotels)', '{"1": "ДДС", "2": "VAT"}', 9, 23],
  ['m', 'Bulgaria 0% (reduced: medical)', '{"1": "ДДС", "2": "VAT"}', 0, 23],
  ['st', 'Croatia 25% (standard)', '{"1": "ДДС", "2": "VAT"}', 25, 97],
  [
    '',
    'Croatia 13% (reduced: hotels / newspapers)',
    '{"1": "ДДС", "2": "VAT"}',
    13,
    97
  ],
  ['st', 'Cyprus 19% (standard)', '{"1": "ДДС", "2": "VAT"}', 19, 54],
  ['', 'Cyprus 9% (reduced: hotels)', '{"1": "ДДС", "2": "VAT"}', 9, 54],
  [
    'm',
    'Cyprus 5% (reduced: food / books / pharma / medical)',
    '{"1": "ДДС", "2": "VAT"}',
    5,
    54
  ],
  ['st', 'Czech Republic 21% (standard)', '{"1": "ДДС", "2": "VAT"}', 21, 55],
  [
    'm',
    'Czech Republic 15% (reduced: food / medical / pharma / hotels)',
    '{"1": "ДДС", "2": "VAT"}',
    15,
    55
  ],
  [
    '',
    'Czech Republic 10% (reduced: pharma / books)',
    '{"1": "ДДС", "2": "VAT"}',
    10,
    55
  ],
  ['st', 'Denmark 25% (standard)', '{"1": "ДДС", "2": "VAT"}', 25, 58],
  ['st', 'Estonia 20% (standard)', '{"1": "ДДС", "2": "VAT"}', 20, 63],
  [
    'm',
    'Estonia 9% (reduced: books / pharma / medical / hotels)',
    '{"1": "ДДС", "2": "VAT"}',
    9,
    63
  ],
  ['st', 'Finland 24% (standard)', '{"1": "ДДС", "2": "VAT"}', 24, 69],
  [
    '',
    'Finland 14% (reduced: restaurants)',
    '{"1": "ДДС", "2": "VAT"}',
    14,
    69
  ],
  [
    '',
    'Finland 10% (reduced: books / pharma / hotels)',
    '{"1": "ДДС", "2": "VAT"}',
    10,
    69
  ],
  ['st', 'France 20% (standard)', '{"1": "ДДС", "2": "VAT"}', 20, 74],
  [
    '',
    'France 10% (reduced: pharma / hotels / restaurants)',
    '{"1": "ДДС", "2": "VAT"}',
    10,
    74
  ],
  [
    'm',
    'France 5.5% (reduced: medicals / food / books)',
    '{"1": "ДДС", "2": "VAT"}',
    5.5,
    74
  ],
  [
    '',
    'France 2.1% (reduced: newspapers / pharma)',
    '{"1": "ДДС", "2": "VAT"}',
    2.1,
    74
  ],
  ['st', 'Germany 19% (standard)', '{"1": "ДДС", "2": "VAT"}', 19, 56],
  [
    'm',
    'Germany 7% (reduced: food / medical / books / hotels)',
    '{"1": "ДДС", "2": "VAT"}',
    7,
    56
  ],
  ['st', 'Greece 24% (standard)', '{"1": "ДДС", "2": "VAT"}', 24, 88],
  [
    'm',
    'Greece 13% (reduced: food / pharma / medical)',
    '{"1": "ДДС", "2": "VAT"}',
    13,
    88
  ],
  [
    '',
    'Greece 6% (reduced: books / hotels)',
    '{"1": "ДДС", "2": "VAT"}',
    6,
    88
  ],
  ['st', 'Hungary 27% (standard)', '{"1": "ДДС", "2": "VAT"}', 27, 99],
  [
    '',
    'Hungary 18% (reduced: food / hotels)',
    '{"1": "ДДС", "2": "VAT"}',
    18,
    99
  ],
  [
    'm',
    'Hungary 5% (reduced: books / medical)',
    '{"1": "ДДС", "2": "VAT"}',
    5,
    99
  ],
  ['st', 'Ireland 23% (standard)', '{"1": "ДДС", "2": "VAT"}', 23, 101],
  [
    'm',
    'Ireland 13.5% (reduced: medical)',
    '{"1": "ДДС", "2": "VAT"}',
    13.5,
    101
  ],
  [
    '',
    'Ireland 9% (reduced: newspapers / hotels / restaurants)',
    '{"1": "ДДС", "2": "VAT"}',
    9,
    101
  ],
  ['', 'Ireland 4.8% (reduced: food)', '{"1": "ДДС", "2": "VAT"}', 4.8, 101],
  [
    'm',
    'Ireland 0% (free: books / medical / children clothing)',
    '{"1": "ДДС", "2": "VAT"}',
    0,
    101
  ],
  ['st', 'Italy 22% (standard)', '{"1": "ДДС", "2": "VAT"}', 22, 109],
  [
    '',
    'Italy 10% (reduced: transport / hotels / restaurants)',
    '{"1": "ДДС", "2": "VAT"}',
    10,
    109
  ],
  [
    'm',
    'Italy 4% (reduced: food / medical / books)',
    '{"1": "ДДС", "2": "VAT"}',
    4,
    109
  ],
  ['', 'Latvia 21% (standard)', '{"1": "ДДС", "2": "VAT"}', 21, 134],
  [
    'm',
    'Latvia 12% (reduced: books / pharma / medical / hotels)',
    '{"1": "ДДС", "2": "VAT"}',
    12,
    134
  ],
  ['st', 'Lithuania 21% (standard)', '{"1": "ДДС", "2": "VAT"}', 21, 132],
  ['', 'Lithuania 9% (reduced: books)', '{"1": "ДДС", "2": "VAT"}', 9, 132],
  ['m', 'Lithuania 5% (reduced: medical)', '{"1": "ДДС", "2": "VAT"}', 5, 132],
  ['st', 'Luxembourg 17% (standard)', '{"1": "ДДС", "2": "VAT"}', 17, 133],
  [
    '',
    'Luxembourg 14% (reduced: wine / advertising)',
    '{"1": "ДДС", "2": "VAT"}',
    14,
    133
  ],
  [
    '',
    'Luxembourg 8% (reduced: bikes / domestic)',
    '{"1": "ДДС", "2": "VAT"}',
    8,
    133
  ],
  [
    'm',
    'Luxembourg 3% (reduced: food / books / pharma / medical / hotels / restaurants)',
    '{"1": "ДДС", "2": "VAT"}',
    3,
    133
  ],
  ['st', 'Malta 18% (standard)', '{"1": "ДДС", "2": "VAT"}', 18, 152],
  ['', 'Malta 7% (reduced: hotels)', '{"1": "ДДС", "2": "VAT"}', 7, 152],
  [
    'm',
    'Malta 5% (reduced: books / medical)',
    '{"1": "ДДС", "2": "VAT"}',
    5,
    152
  ],
  ['', 'Malta 0% (reduced: food / pharma)', '{"1": "ДДС", "2": "VAT"}', 0, 152],
  ['st', 'Netherlands 21% (standard)', '{"1": "ДДС", "2": "VAT"}', 21, 165],
  [
    'm',
    'Netherlands 6% (reduced: food / books / pharma / medical / hotels)',
    '{"1": "ДДС", "2": "VAT"}',
    6,
    165
  ],
  ['', 'Poland 23% (standard)', '{"1": "ДДС", "2": "VAT"}', 23, 178],
  [
    'm',
    'Poland 8% (reduced: pharma / medical / hotels / restaurants)',
    '{"1": "ДДС", "2": "VAT"}',
    8,
    178
  ],
  ['', 'Poland 5% (reduced: food)', '{"1": "ДДС", "2": "VAT"}', 5, 178],
  ['st', 'Portugal 23% (standard)', '{"1": "ДДС", "2": "VAT"}', 23, 183],
  ['', 'Portugal 13% (reduced: food)', '{"1": "ДДС", "2": "VAT"}', 13, 183],
  [
    'm',
    'Portugal 6% (reduced: food / books / pharma / medical / hotels)',
    '{"1": "ДДС", "2": "VAT"}',
    6,
    183
  ],
  ['st', 'Romania 24% (standard)', '{"1": "ДДС", "2": "VAT"}', 24, 188],
  [
    '',
    'Romania 5% (reduced: social housing)',
    '{"1": "ДДС", "2": "VAT"}',
    5,
    188
  ],
  [
    'm',
    'Romania 9% (reduced: books / pharma / medical / hotels)',
    '{"1": "ДДС", "2": "VAT"}',
    9,
    188
  ],
  ['st', 'Slovakia 20% (standard)', '{"1": "ДДС", "2": "VAT"}', 20, 201],
  [
    'm',
    'Slovakia 10% (reduced: books / food / medical / pharma)',
    '{"1": "ДДС", "2": "VAT"}',
    10,
    201
  ],
  ['', 'Slovenia 22% (standard)', '{"1": "ДДС", "2": "VAT"}', 22, 199],
  [
    'm',
    'Slovenia 9.5% (reduced: food / books / pharma / medical / hotels)',
    '{"1": "ДДС", "2": "VAT"}',
    9.5,
    199
  ],
  ['st', 'Spain 21% (standard)', '{"1": "ДДС", "2": "VAT"}', 21, 67],
  [
    'm',
    'Spain 10% (reduced: medical / pharma)',
    '{"1": "ДДС", "2": "VAT"}',
    10,
    67
  ],
  [
    '',
    'Spain 4% (reduced: food / newspapers)',
    '{"1": "ДДС", "2": "VAT"}',
    4,
    67
  ],
  ['', 'Spain 0% (Tenerife) (standard)', '{"1": "ДДС", "2": "VAT"}', 0, 67],
  ['', 'Spain 0% (Las Palmas) (standard)', '{"1": "ДДС", "2": "VAT"}', 0, 67],
  ['', 'Spain 0% (Melilla) (standard)', '{"1": "ДДС", "2": "VAT"}', 0, 67],
  ['', 'Spain 0% (Ceuta) (standard)', '{"1": "ДДС", "2": "VAT"}', 0, 67],
  ['st', 'Sweden 25% (standard)', '{"1": "ДДС", "2": "VAT"}', 25, 196],
  ['', 'Sweden 12% (reduced: food)', '{"1": "ДДС", "2": "VAT"}', 12, 196],
  ['', 'Sweden 6% (reduced: books)', '{"1": "ДДС", "2": "VAT"}', 6, 196],
  ['st', 'United Kingdom 20% (standard)', '{"1": "ДДС", "2": "VAT"}', 20, 76],
  [
    '',
    'United Kingdom 5% (reduced: property renovations)',
    '{"1": "ДДС", "2": "VAT"}',
    5,
    76
  ],
  [
    'm',
    'United Kingdom 0% (reduced: food / books / pharma / medical)',
    '{"1": "ДДС", "2": "VAT"}',
    0,
    76
  ]
];

void main() {
  final List SttaxRateId = [];
  final List MtaxRateId = [];
  for (int i = 0; i < countryTax.length; i++) {
    if (countryTax[i].first == 'st') {
      SttaxRateId.add(i + 1);
    } else if (countryTax[i].first == 'm') {
      MtaxRateId.add(i + 1);
    }
  }
  // ignore: avoid_print
  print(SttaxRateId.map((r) => '"$r": true').join(', '));
  // ignore: avoid_print
  print(MtaxRateId.map((r) => '"$r": true').join(','));
}
