// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mktk_app/src/configuration/widgets/custom_input.dart';
import 'package:mktk_app/src/configuration/widgets/profile_item.dart';
import 'package:mktk_app/src/configuration/widgets/search_btn.dart';
import 'package:mktk_app/src/shared/models/profile.model.dart';
import 'package:mktk_app/src/shared/services/api.service.dart';
import 'package:mktk_app/src/shared/storage/configuration/profile.storage.dart';

class ProfilesPage extends StatefulWidget {
  const ProfilesPage({super.key});

  @override
  State<ProfilesPage> createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController limitUptime = TextEditingController();
  TextEditingController price = TextEditingController();
  String dropdownValue = '';
  MkTkAPI api = MkTkAPI('/ip/hotspot/user/profile');
  bool isLoading = false;
  bool isEditing = false;
  List<Widget> profiles = [];
  List<Map<String, String>> mktkList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfiles();
    });
  }

  @override
  void dispose() {
    super.dispose();
    limitUptime.dispose();
    price.dispose();
  }

  Future<void> _loadProfiles() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Map<String, dynamic>> result = await ProfileStorage.getInfo(true);
      debugPrint('PROFILES: $result');
      setState(() {
        profiles = result.map((e) {
          Profile profile = Profile(
            id: e['id'],
            mktkId: e['mktk_id'],
            name: e['name'],
            limitUptime: e['limit_uptime'],
            price: e['price'],
          );
          return ProfileItem(
            profile,
            () async {
              await deleteProfile(profile);
              await _loadProfiles();
            },
            () async {
              await loadMkTkProfiles();
              showVoucher(context, editId: profile.id.toString());
              updateProfile(profile);
            },
          );
        }).toList();
      });
    } catch (e) {
      debugPrint('=== LOAD PROFILES ERROR: ${e.toString()}');
      _messageBox(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> loadMkTkProfiles() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<dynamic> result = await api.cmdPrint();
      // debugPrint('Result: $result');
      setState(() {
        mktkList = result
            .map((el) => {
                  'id': el['.id'] as String,
                  'name': el['name'] as String,
                })
            .toList();
        dropdownValue = "${mktkList.first['id']}|${mktkList.first['name']}";
      });
      debugPrint('Value: $dropdownValue');
      debugPrint('List: $mktkList');
    } catch (e) {
      debugPrint('=== LOAD MKTK PROFILES ERROR: ${e.toString()}');
      _messageBox(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> createProfile({String? editId}) async {
    if (_formKey.currentState!.validate()) {
      try {
        List<String> value = dropdownValue.split('|');
        Profile profile = Profile(
          mktkId: value[0],
          name: value[1],
          limitUptime: limitUptime.text.trim(),
          price: double.parse(price.text.trim()),
        );
        debugPrint('PROFILE: $profile');
        if (isEditing) {
          if (editId!.isNotEmpty) {
            profile.id = int.parse(editId);
          }
          ProfileStorage.edit(profile);
          isEditing = false;
        } else {
          ProfileStorage.create(profile);
        }
        _messageBox("As informações foram salvas!");
        _clearForm();
        await _loadProfiles();
      } catch (e) {
        debugPrint('=== INFO PAGE SAVE ERROR: ${e.toString()}');
        _messageBox(e.toString());
      }
    }
  }

  void updateProfile(Profile profile) {
    setState(() {
      isEditing = true;
      limitUptime.text = profile.limitUptime;
      price.text = profile.price.toString();
    });
  }

  Future<void> deleteProfile(Profile profile) async {
    setState(() {
      isLoading = true;
    });
    try {
      dynamic result = await ProfileStorage.delete(profile);
      debugPrint('RESULT: $result');
      _messageBox('O profile foi removido!');
    } catch (e) {
      debugPrint('=== DELETE PROFILE ERROR: ${e.toString()}');
      _messageBox(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _messageBox(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
          label: 'Fechar',
          onPressed: () {},
        ),
      ),
    );
  }

  void _clearForm() {
    limitUptime.clear();
    price.clear();
  }

  void showVoucher(BuildContext context, {String? editId}) {
    Widget createBtn = ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(
          Color(0xFF4758A9),
        ),
      ),
      child: const Text(
        'Criar',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () async {
        await createProfile(editId: editId);
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      content: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20.0,
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  value: dropdownValue,
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = value!;
                    });
                  },
                  items: mktkList.map<DropdownMenuItem<String>>((el) {
                    debugPrint('el: $el');
                    return DropdownMenuItem<String>(
                      value: "${el['id']}|${el['name']}",
                      child: Text("${el['name']}"),
                    );
                  }).toList(),
                ),
              ),
              CustomInput(
                control: limitUptime,
                label: 'Limit Uptime',
                placeholder: '12d 08:00:00',
              ),
              CustomInput(
                label: "Preço",
                control: price,
                placeholder: '5.95',
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        createBtn,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: profiles.isNotEmpty
                        ? profiles
                        : [
                            const Text('Nenhum profile cadastrado...'),
                          ],
                  ),
          ),
          SearchBtn(
            onPressed: () async {
              await loadMkTkProfiles();
              showVoucher(context);
            },
            title: 'Adicionar',
          ),
        ],
      ),
    );
  }
}
