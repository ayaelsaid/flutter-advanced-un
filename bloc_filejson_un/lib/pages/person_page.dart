import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/person_bloc.dart';
import '../bloc/person_state.dart';
import '../bloc/person_event.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  @override
  void initState() {
    super.initState();
    context.read<PersonBloc>().add(LoadPerson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persons'),
      ),
      body: BlocBuilder<PersonBloc, PersonState>(
        builder: (context, state) {
          if (state is PersonLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PersonLoaded) {
            return ListView.builder(
              itemCount: state.persons.length,
              itemBuilder: (context, index) {
                final person = state.persons[index];
                return ListTile(
                  title: Text(person.name),
                  subtitle: Text(person.email),
                );
              },
            );
          } else if (state is PersonError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Press button to load persons'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<PersonBloc>().add(LoadPerson());
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
