class WorkoutExercise{
    constructor(id, name, description, bodyPart, push, image, video, equipment, day,sets) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.image = image;
        this.bodyPart = bodyPart;
        this.bodyDomain = bodyDomain;
        this.push = push;
        this.equipment = equipment;
        this.day = day;
        this.sets = sets;
    }
}

module.exports = WorkoutExercise;