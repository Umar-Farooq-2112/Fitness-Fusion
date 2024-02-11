class FoodItem {
    constructor(id, name, description, image, calories, fats, protein, carbohydrates, fibre, sugar) {
      this.id = id;
      this.name = name;
      this.description = description;
      this.image = image ? image.toString('base64') : null; // Convert BLOB to base64
      this.calories = calories;
      this.fats = fats;
      this.protein = protein;
      this.carbohydrates = carbohydrates;
      this.fibre = fibre;
      this.sugar = sugar;
    }
  }
module.exports = FoodItem