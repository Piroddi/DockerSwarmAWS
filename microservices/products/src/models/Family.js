const { Schema, model } = require('mongoose');

const FamilySchema = new Schema({
  createdAt: {
    type: String
  },
  updatedAt: {
    type: String
  },
  timestamp: {
    type: Number
  },
  lastName: {
    type: String,
    required: true
  },
  familyMembers: {
    type: [String],
    default: undefined
  }
});

const Family = model('family', FamilySchema);
module.exports = Family;
