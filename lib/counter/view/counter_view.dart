import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_cubit/counter/counter.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterCubit, CounterState>(
      listener: (context, state) {
        if (state.isMultipleOfFive) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Text(
                    'You got ${state.count}!',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              backgroundColor: const Color.fromARGB(255, 8, 168, 117),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Counter App'),
            backgroundColor: const Color.fromARGB(255, 8, 168, 117),
          ),
          body: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 209, 207, 207),
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
                  // Show Image in the center of the page when the count is a multiple of 5
                  if (state.isMultipleOfFive)
                    Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 8, 168, 117),
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 12, 100, 42).withOpacity(0.5),
                              blurRadius: 15,
                              spreadRadius: 8,
                            )
                          ],
                        ),
                        child: Image.asset(
                          'assets/meme.jpg',
                          width: 150,  // Adjust size of the image
                          height: 150, // Adjust size of the image
                        ),
                      ),
                    ),
                  const SizedBox(height: 40),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: state.isMultipleOfFive
                          ? const Color.fromARGB(255, 8, 168, 117)
                          : const Color.fromARGB(255, 12, 100, 42).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: state.isMultipleOfFive
                          ? [
                              BoxShadow(
                                color: const Color.fromARGB(255, 12, 100, 42).withOpacity(0.5),
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
                            : const Color.fromARGB(255, 12, 100, 42),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => context.read<CounterCubit>().decrement(),
                        icon: const Icon(Icons.remove),
                        label: const Text('Kurang 1'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 8, 168, 117),
                          foregroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton.icon(
                        onPressed: () => context.read<CounterCubit>().increment(),
                        icon: const Icon(Icons.add),
                        label: const Text('Tambah 1'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 245, 120, 37),
                          foregroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton.icon(
                        onPressed: () => context.read<CounterCubit>().decrementByTwo(),
                        icon: const Icon(Icons.exposure_minus_2),
                        label: const Text('Kurang 2'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 240, 27, 115),
                          foregroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton.icon(
                        onPressed: () => context.read<CounterCubit>().multiplyByTwo(),
                        icon: const Icon(Icons.close),
                        label: const Text('Kali 2'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 16, 158, 240),
                          foregroundColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton.icon(
                        onPressed: () => context.read<CounterCubit>().reset(),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Reset'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 236, 240, 39),
                          foregroundColor: Colors.white,
                        ),
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
