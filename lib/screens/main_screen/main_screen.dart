import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/main_screen_cubit.dart';
import 'cubit/main_screen_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();
  final _massController = TextEditingController();
  final _radiusController = TextEditingController();
  bool _agreement = false;


  void _onPressed() {
    if (!_formKey.currentState!.validate()) return;

    // вместо Navigator.push — вызываем метод кубита
    context.read<MainScreenCubit>().calculate(
          mass: double.parse(_massController.text),
          radius: double.parse(_radiusController.text),
          agreement: _agreement,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Сараев Дмитрий Юрьевич')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Введите массу небесного тела, кг.:',
                  style: TextStyle(fontSize: 20.0)),
              TextFormField(
                controller: _massController,
                keyboardType: TextInputType.number,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Введите массу' : null,
              ),
              const SizedBox(height: 10),
              const Text('Введите радиус небесного тела, км.:',
                  style: TextStyle(fontSize: 20.0)),
              TextFormField(
                controller: _radiusController,
                keyboardType: TextInputType.number,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Введите радиус' : null,
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                value: _agreement,
                title: const Text('Согласие на обработку персональных данных'),
                onChanged: (v) => setState(() => _agreement = v ?? false),
              ),
              const SizedBox(height: 10),

              // здесь UI реагирует на состояние кубита
              BlocBuilder<MainScreenCubit, MainScreenState>(
                builder: (context, state) {
                  if (state is MainScreenResultState) {
                    return Center(
                      child: Text(
                        'Первая космическая скорость:\n'
                        '${state.result.toStringAsFixed(2)} м/с',
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  if (state is MainScreenErrorState) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  // начальное состояние — ничего не показываем
                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _onPressed,
                  child: const Text('Проверить'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}