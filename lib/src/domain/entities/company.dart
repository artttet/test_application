class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  const Company._empty()
      : name = '',
        catchPhrase = '',
        bs = '';
}

class CompanyEmpty extends Company {
  const CompanyEmpty() : super._empty();
}