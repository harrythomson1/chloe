conditions_data = [
  {
    name: "Migraine",
    slug: "migraine",
    description: "A migraine is usually a moderate or severe headache felt as a throbbing pain on one side of the head.",
    source_url: "https://www.nhs.uk/conditions/migraine/",
    symptoms: ["Intense headache", "Nausea", "Vomiting", "Sensitivity to light", "Sensitivity to sound", "Visual disturbances"]
  },
  {
    name: "Type 2 Diabetes",
    slug: "type-2-diabetes",
    description: "Type 2 diabetes is a common condition that causes the level of sugar in the blood to become too high.",
    source_url: "https://www.nhs.uk/conditions/type-2-diabetes/",
    symptoms: ["Urinating more than usual", "Feeling thirsty all the time", "Feeling very tired", "Blurred vision", "Slow healing cuts or wounds", "Unexplained weight loss"]
  },
  {
    name: "Asthma",
    slug: "asthma",
    description: "Asthma is a common lung condition that causes occasional breathing difficulties.",
    source_url: "https://www.nhs.uk/conditions/asthma/",
    symptoms: ["Wheezing", "Breathlessness", "Chest tightness", "Coughing"]
  },
  {
    name: "Hypertension",
    slug: "hypertension",
    description: "High blood pressure, or hypertension, rarely has noticeable symptoms but if untreated increases your risk of serious problems.",
    source_url: "https://www.nhs.uk/conditions/high-blood-pressure-hypertension/",
    symptoms: ["Headaches", "Blurred vision", "Chest pain", "Shortness of breath", "Dizziness"]
  },
  {
    name: "Irritable Bowel Syndrome",
    slug: "irritable-bowel-syndrome",
    description: "Irritable bowel syndrome (IBS) is a common condition that affects the digestive system.",
    source_url: "https://www.nhs.uk/conditions/irritable-bowel-syndrome-ibs/",
    symptoms: ["Stomach cramps", "Bloating", "Diarrhoea", "Constipation", "Flatulence", "Nausea"]
  },
  {
    name: "Anxiety",
    slug: "anxiety",
    description: "Anxiety is a feeling of unease, such as worry or fear, that can be mild or severe.",
    source_url: "https://www.nhs.uk/conditions/generalised-anxiety-disorder/",
    symptoms: ["Feeling restless or worried", "Trouble sleeping", "Dizziness", "Heart palpitations", "Muscle tension", "Sweating"]
  },
  {
    name: "Eczema",
    slug: "eczema",
    description: "Atopic eczema causes the skin to become itchy, dry, cracked and sore.",
    source_url: "https://www.nhs.uk/conditions/atopic-eczema/",
    symptoms: ["Itchy skin", "Dry skin", "Red or inflamed skin", "Cracked skin", "Sore skin"]
  },
  {
    name: "Depression",
    slug: "depression",
    description: "Depression is more than simply feeling unhappy or fed up for a few days.",
    source_url: "https://www.nhs.uk/conditions/depression/",
    symptoms: ["Persistent low mood", "Feeling hopeless", "Low energy", "Disturbed sleep", "Loss of appetite", "Loss of interest in activities"]
  }
]

# Medications
medications_data = [
  { name: "Paracetamol", slug: "paracetamol", description: "A common painkiller used to treat aches and pain. It can also be used to reduce a high temperature.", rx_norm_id: "161" },
  { name: "Ibuprofen", slug: "ibuprofen", description: "A widely used painkiller and anti-inflammatory medicine.", rx_norm_id: "5640" },
  { name: "Metformin", slug: "metformin", description: "A medicine used to treat type 2 diabetes and sometimes polycystic ovary syndrome.", rx_norm_id: "6809" },
  { name: "Salbutamol", slug: "salbutamol", description: "A reliever inhaler used to treat the symptoms of asthma and chronic obstructive pulmonary disease.", rx_norm_id: "9054" },
  { name: "Lisinopril", slug: "lisinopril", description: "A medicine used to treat high blood pressure and heart failure.", rx_norm_id: "29046" },
  { name: "Sertraline", slug: "sertraline", description: "A type of antidepressant often used to treat depression and anxiety disorders.", rx_norm_id: "36437" },
  { name: "Amitriptyline", slug: "amitriptyline", description: "A medicine used to treat depression and nerve pain. Also used to prevent migraines.", rx_norm_id: "718" },
  { name: "Omeprazole", slug: "omeprazole", description: "A medicine that reduces the amount of acid your stomach makes.", rx_norm_id: "7646" }
]

puts "Seeding symptoms and conditions..."

conditions_data.each do |condition_data|
  condition = Condition.find_or_create_by(slug: condition_data[:slug]) do |c|
    c.name = condition_data[:name]
    c.description = condition_data[:description]
    c.source_url = condition_data[:source_url]
  end

  condition_data[:symptoms].each do |symptom_name|
    symptom = Symptom.find_or_create_by(slug: symptom_name.downcase.gsub(" ", "-")) do |s|
      s.name = symptom_name
    end

    ConditionSymptom.find_or_create_by(condition: condition, symptom: symptom)
  end
end

puts "Seeding medications..."

medications_data.each do |medication_data|
  Medication.find_or_create_by(slug: medication_data[:slug]) do |m|
    m.name = medication_data[:name]
    m.description = medication_data[:description]
    m.rx_norm_id = medication_data[:rx_norm_id]
  end
end

puts "Done! Seeded #{Condition.count} conditions, #{Symptom.count} symptoms, #{Medication.count} medications"
