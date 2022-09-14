
class BmiCalculation {
  static double calculateBmiIndex(int weight, int height) {
    return weight / (height * height) * 10000;
  }

  static String calculateBmiVerdict(double calculatedBmi) {
    String verdict = "Unknown BMI index";
    if (calculatedBmi >= 30) {
      verdict = "Obese";
    } else if (calculatedBmi >= 25.000000000) {
      verdict = "Overweight";
    } else if (calculatedBmi >= 18.555555555) {
      verdict = "Normal weight";
    } else if (calculatedBmi >= 0) {
      verdict = "Underweight";
    }
    return verdict;
  }
}