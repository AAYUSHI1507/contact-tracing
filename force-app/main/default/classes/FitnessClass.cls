public class FitnessClass {
    private  Decimal weight;
    private  Decimal height;
    
    //initiallization block
    {
        System.debug('This is the intialization block..');
        weight = 21.3;
        height = 4.6;
    }
   //static block
    static{
        System.debug('This is the static intialization block.. 1');
    }
    /**
  * CalculateBMI method.
  * accepts body weight (should be in kg)
  * and body height (should be in meter)
  * returns BMI value
**/
    public static Decimal calculateBMI(Decimal weight, Decimal height){
        Decimal result = weight/(height*height);
        return result;
    }
    
    public static Decimal calculatePace(Decimal distance,Decimal minutes){
        Decimal hr = minutes/60;
        Decimal pace = distance/hr;
        return pace;
    }
    
}