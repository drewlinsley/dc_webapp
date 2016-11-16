function getRandomItem(list)
{
    // Return random list element
    return list[Math.floor(Math.random()*list.length)];
}

exports.generateRandomName = function ()
{
    var adjectives = ["Abandoned", "Able", "Adventurous", "Agile", "Ancient", "Athletic", "Altruistic", "Attentive", "Awesome", "Accomplished", "Academic", "Absolute", "Amazing", "Anguished", "Apprehensive", "Authentic"];
    var nouns = ["Abyssinian", "Akita", "Alligator", "Afghan Hound", "African Penguin", "Angelfish", "Ant", "Antelope", "Arctic Fox", "Armadillo", "Avocet", "Axolotl", "Asian Elephant", "Australian Terrier"];
    return getRandomItem(adjectives) + " " + getRandomItem(nouns);
}

exports.clone = function(o) { return JSON.parse(JSON.stringify(o)); }