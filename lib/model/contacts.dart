class Contacts {
  String contact1;
  String contact2;
  String city;
  String office;
  String location;

  Contacts(
      {required this.contact1,
      required this.contact2,
      required this.city,
      required this.office,
      required this.location});

  static List<Contacts> contactList() {
    return [
      Contacts(
          city: 'Trichy',
          contact1: '7867014908',
          contact2: '7904042744',
          office: 'Head Office',
          location: '10.792251,78.695365'),
      Contacts(
          city: 'Vaiyampatty',
          contact1: '8489939931',
          contact2: '8489939939',
          office: 'Register Office',
          location: '10.552673,78.304619'),
      Contacts(
          city: 'Karaikudi',
          contact1: '7094458999',
          contact2: '7094949442',
          office: 'Branch Office',
          location: '10.070820,78.779965'),
      Contacts(
          city: 'Dindigul',
          contact1: '7867014294',
          contact2: '9159449447',
          office: 'Branch Office',
          location: '10.357960,77.979299'),
      Contacts(
          city: 'Karur',
          contact1: '7867014293',
          contact2: '8489948003',
          office: 'Branch Office',
          location: '10.923904,78.092293'),
      Contacts(
          city: 'Thanjavur',
          contact1: '7867014595',
          contact2: '7094949455',
          office: 'Branch Office',
          location: '10.769256,79.114919'),
      Contacts(
          city: 'Tharagampatti',
          contact1: '9840061442',
          contact2: '7867014292',
          office: 'Branch Office',
          location: '10.706194,78.238984'),
      Contacts(
          city: 'Thuvarankurichi',
          contact1: '7867014619',
          contact2: '9942686896',
          office: 'Branch Office',
          location: '10.386758,78.376413'),
      Contacts(
          city: 'Madurai',
          contact1: '7094949442',
          contact2: '7867014591',
          office: 'Branch Office',
          location: '9.905177,78.145260'),
    ];
  }
}
