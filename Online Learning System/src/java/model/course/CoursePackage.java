package model.course;

public class CoursePackage {

    private int packageID;
    private int courseID;
    private String packageName;
    private double originalPrice;
    private int saleRate;
    private int useTime;
    private String description;

    public CoursePackage() {
    }

    public CoursePackage(int packageID, int courseID, String packageName, double originalPrice, int saleRate, int useTime, String description) {
        this.packageID = packageID;
        this.courseID = courseID;
        this.packageName = packageName;
        this.originalPrice = originalPrice;
        this.saleRate = saleRate;
        this.useTime = useTime;
        this.description = description;
    }

    public int getPackageID() {
        return packageID;
    }

    public void setPackageID(int packageID) {
        this.packageID = packageID;
    }

    public int getCourseID() {
        return courseID;
    }

    public void setCourseID(int courseID) {
        this.courseID = courseID;
    }

    public String getPackageName() {
        return packageName;
    }

    public void setPackageName(String packageName) {
        this.packageName = packageName;
    }

    public double getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(double originalPrice) {
        this.originalPrice = originalPrice;
    }

    public int getSaleRate() {
        return saleRate;
    }

    public void setSaleRate(int saleRate) {
        this.saleRate = saleRate;
    }

    public int getUseTime() {
        return useTime;
    }

    public void setUseTime(int useTime) {
        this.useTime = useTime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
