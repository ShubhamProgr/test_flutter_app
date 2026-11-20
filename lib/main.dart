import 'package:flutter/material.dart';

void main() {
  runApp(const QuestionnaireApp());
}

class QuestionnaireApp extends StatelessWidget {
  const QuestionnaireApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Questionnaire',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const QuestionnairePage(),
    );
  }
}

class Question {
  const Question(this.text, this.options, this.answer);

  final String text;
  final List<String> options;
  final String answer;
}

const List<Question> questions = [
  Question(
    'What is the capital of France?',
    ['London', 'Paris', 'Berlin', 'Madrid'],
    'Paris',
  ),
  Question(
    'Which planet is known as the Red Planet?',
    ['Venus', 'Jupiter', 'Mars', 'Saturn'],
    'Mars',
  ),
  Question(
    'What is 7 x 6?',
    ['36', '42', '48', '56'],
    '42',
  ),
  Question(
    'Which language is used to build Flutter apps?',
    ['Kotlin', 'Swift', 'Dart', 'Java'],
    'Dart',
  ),
  Question(
    'What is the largest ocean on Earth?',
    ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
    'Pacific',
  ),
];

class QuestionnairePage extends StatefulWidget {
  const QuestionnairePage({super.key});

  @override
  State<QuestionnairePage> createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {
  int _index = 0;
  int _score = 0;

  void _answer(String option) {
    if (option == questions[_index].answer) {
      _score++;
    }
    setState(() {
      _index++;
    });
  }

  void _restart() {
    setState(() {
      _index = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final finished = _index >= questions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionnaire'),
        centerTitle: true,
      ),
      body: finished ? _buildResult(context) : _buildQuestion(context),
    );
  }

  Widget _buildQuestion(BuildContext context) {
    final question = questions[_index];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Question ${_index + 1} of ${questions.length}',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: _index / questions.length),
          const SizedBox(height: 24),
          Text(
            question.text,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          for (final option in question.options)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: FilledButton.tonal(
                onPressed: () => _answer(option),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(option),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildResult(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events, size: 72, color: Colors.amber),
            const SizedBox(height: 16),
            Text(
              'You scored $_score out of ${questions.length}',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _restart,
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
