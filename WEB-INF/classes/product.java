import java.io.Serializable;

public class product implements Serializable {
    public static final long serialVersionUID = -1L;
    private String id, qty, price, description, image, name,catID, date;

    public product() {
    }
    public String getID() {
        return this.id;
    }
    
    public void setID(String id) {
        this.id = id;
    }
    public String getCatID() {
        return this.catID;
    }
    
    public void setCatID(String catID) {
        this.catID = catID;
    }
    public String getPrice() {
        return this.price;
    }
    public void setPrice(String price) {
        this.price = price;
    }
    public String getQty() {
        return this.qty;
    }
    public void setQty(String qty) {
        this.qty = qty;
    }
    public String getName() {
        return this.name;
    }
    public void setName(String name) {
        this.name = name;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    public String getDescription() {
        return this.description;
    }
    public String getImage() {
        return this.image;
    }
    public void setImage(String image) {
        this.image = image;
    }

    public String getDate() {
        return this.date;
    }

    public void setDate(String date) {
        this.date = date;
    }



    
    
}