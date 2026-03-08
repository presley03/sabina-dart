import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabina/generated/app_localizations.dart';
import '../../models/preeclampsia_model.dart';
import 'preeclampsia_result_screen.dart';

class QuestionnaireScreenModern extends StatelessWidget {
  const QuestionnaireScreenModern({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Consumer<PreeclampsiaScreeningModel>(
      builder: (context, model, child) {
        if (model.isQuestionnaireCompleted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ResultScreen()),
            );
          });
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              localizations.preeclampsiaQuestionnaire,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.pink[600],
            elevation: 0,
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildProgressSection(model, localizations),
                  const SizedBox(height: 30),
                  Expanded(
                    child: _buildQuestionCard(context, model, localizations),
                  ),
                  const SizedBox(height: 30),
                  _buildAnswerButtons(context, model, localizations),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressSection(
      PreeclampsiaScreeningModel model, AppLocalizations localizations) {
    final progress = (model.currentQuestionIndex + 1) / model.questions.length;

    return Column(
      children: [
        // Progress indicator
        Container(
          width: 120,
          height: 120,
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.pink[600]!),
                    strokeWidth: 8,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${model.currentQuestionIndex + 1}',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[600],
                      ),
                    ),
                    Text(
                      'of ${model.questions.length}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(Colors.pink[600]!),
          minHeight: 6,
        ),
      ],
    );
  }

  Widget _buildQuestionCard(BuildContext context,
      PreeclampsiaScreeningModel model, AppLocalizations localizations) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.pink[50]!,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.help_outline,
              size: 48,
              color: Colors.pink[600],
            ),
            const SizedBox(height: 20),
            Text(
              _getLocalizedQuestion(model.currentQuestionIndex, localizations),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Question ${model.currentQuestionIndex + 1} of ${model.questions.length}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.pink[800],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerButtons(BuildContext context,
      PreeclampsiaScreeningModel model, AppLocalizations localizations) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 70,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[500],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
              ),
              onPressed: () => model.answerQuestion(true),
              icon: const Icon(Icons.check_circle, size: 28),
              label: Text(
                localizations.yes,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            height: 70,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[500],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
              ),
              onPressed: () => model.answerQuestion(false),
              icon: const Icon(Icons.cancel, size: 28),
              label: Text(
                localizations.no,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _getLocalizedQuestion(int index, AppLocalizations localizations) {
    switch (index) {
      case 0:
        return localizations.preeclampsiaQuestion1;
      case 1:
        return localizations.preeclampsiaQuestion2;
      case 2:
        return localizations.preeclampsiaQuestion3;
      case 3:
        return localizations.preeclampsiaQuestion4;
      case 4:
        return localizations.preeclampsiaQuestion5;
      case 5:
        return localizations.preeclampsiaQuestion6;
      case 6:
        return localizations.preeclampsiaQuestion7;
      case 7:
        return localizations.preeclampsiaQuestion8;
      case 8:
        return localizations.preeclampsiaQuestion9;
      case 9:
        return localizations.preeclampsiaQuestion10;
      default:
        return 'Question not found';
    }
  }
}
