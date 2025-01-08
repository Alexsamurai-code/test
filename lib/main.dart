import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Package {
  final String name;
  final String latestVersion;
  final String? description;

  Package(this.name, this.latestVersion, {this.description});

  @override
  String toString() {
    return 'Package{name: $name, latestVersion: $latestVersion, description: $description}';
  }
}

void main() async {
  print('Введіть ім\'я пакета (наприклад, http):');
  String? packageName = stdin.readLineSync()?.trim();

  if (packageName == null || packageName.isEmpty) {
    print('Ім\'я пакета не може бути порожнім!');
    return;
  }

  final packageUrl = Uri.https('dart.dev', '/f/packages/$packageName.json');
  final packageResponse = await http.get(packageUrl);

  if (packageResponse.statusCode != 200) {
    print('Не вдалося отримати інформацію про пакет $packageName!');
    return;
  }

  final json = jsonDecode(packageResponse.body);
  final package = Package(
    json['name'],
    json['latestVersion'],
    description: json['description'],
  );

  print(package);
}
