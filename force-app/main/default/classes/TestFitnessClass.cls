@isTest
public class TestFitnessClass {
    
    @isTest
    public static void TestBMIcalculatorMethod(){
        FitnessClass f1 = new FitnessClass();
        Decimal trueValue = 24.79338842975207;
        Decimal result = FitnessClass.calculateBMI(67.5, 1.65).setScale(10, System.RoundingMode.UP);
        System.assertEquals(trueValue.setScale(10, System.RoundingMode.UP),result,'The calculated BMI is wrong');
    }
    
    @isTest
    public static void TestPaceCalculator(){
        FitnessClass f2 = new FitnessClass();
        Decimal trueValue = 50;
        Decimal result = FitnessClass.calculatePace(25, 30).setScale(10, System.RoundingMode.UP);
        System.assertEquals(trueValue.setScale(10, System.RoundingMode.UP),result,'The calculated pacemeter is wrong');
    }
}