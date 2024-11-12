import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_cubit/counter/counter.dart';

/// {@template counter_view}
/// A [StatelessWidget] which reacts to the provided
/// [CounterCubit] state and notifies it in response to user input.
/// {@endtemplate}
class CounterView extends StatelessWidget {
  /// {@macro counter_view}
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterCubit, CounterState>(
      listener: (context, state) {
        if (state.isMultipleOfFive) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'You got ${state.count}!',
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: const Color.fromARGB(255, 247, 182, 203),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Counter App'),
            backgroundColor: const Color.fromARGB(255, 249, 119, 167),
          ),
          body: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 209, 207, 207),  // Set background to grey
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Current Count:',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: state.isMultipleOfFive
                          ? Colors.pink.shade400
                          : Colors.pink.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: state.isMultipleOfFive
                          ? [
                              BoxShadow(
                                color: Colors.pink.shade800.withOpacity(0.5),
                                blurRadius: 15,
                                spreadRadius: 8,
                              )
                            ]
                          : null,
                    ),
                    child: Text(
                      '${state.count}',
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.bold,
                        color: state.isMultipleOfFive
                            ? Colors.white
                            : Colors.pink.shade900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Reorganize buttons into a column layout
                  Column(
                    children: [
                      // Basic operation buttons in a row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            onPressed: () =>
                                context.read<CounterCubit>().decrement(),
                            backgroundColor: Colors.pink.shade400,
                            child: const Icon(Icons.remove),
                          ),
                          const SizedBox(width: 20),
                          FloatingActionButton(
                            onPressed: () =>
                                context.read<CounterCubit>().increment(),
                            backgroundColor: Colors.pink.shade600,
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Additional operation buttons in a column layout
                      Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () =>
                                context.read<CounterCubit>().decrementByTwo(),
                            icon: const Icon(Icons.exposure_minus_2),
                            label: const Text('Decrease by 2'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink.shade300,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: () =>
                                context.read<CounterCubit>().multiplyByTwo(),
                            icon: const Icon(Icons.close),
                            label: const Text('Multiply by 2'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink.shade500,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: () => context.read<CounterCubit>().reset(),
                            icon: const Icon(Icons.refresh),
                            label: const Text('Reset'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink.shade700,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
