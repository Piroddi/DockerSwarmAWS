const get = (req, res, next) => {
  try {
    const products = [
      { id: '1a', name: 'Space-X Spaceship Memorabilia' },
      { id: '1b', name: 'Maxed Basketball Ball' }
    ];
    res.status(200).send(products);
  } catch (e) {
    next();
  }
};

const getById = (req, res, next) => {
  const productId = req.params.id;
  const products = [
    { id: '1a', name: 'Space-X Spaceship Memorabilia' },
    { id: '1b', name: 'Maxed Basketball Ball' }
  ];
  try {
    const product = products.filter(product => product.id === productId)[0]

    if(product){
      res.status(200).send(product);
    }else{
      res.status(404).send('No product matching the given id was found');
    }
    
  } catch (e) {
    next();
  }
};

const ProductsController = {
  get,
  getById
};

module.exports = ProductsController;
