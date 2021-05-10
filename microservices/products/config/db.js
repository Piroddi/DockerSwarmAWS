const connectDB = async () => {
  try {
  } catch (err) {
    console.log(err.message);
    // Exit process with failure
    process.exit(1);
  }
};

module.exports = { connectDB };
