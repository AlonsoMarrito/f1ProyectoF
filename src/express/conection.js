// este formato se mantiene igual lo unico que puede cambiar dependiendo la base de datos, es la key

const {Pool} = require('pg');

//se dan las credenciales de la ase de datos mediante un json
const con={
    user: "ugtnawr05tigg",
    port: 5432,
    database: "dbse6goea2cz7o",
    host: "35.215.115.254",
    password: 'Amaranto1'
}

// se define un nuevo "" asi como se le envia el json de la key
const pool = new Pool(con);

//Se mantiene igual esta parte en todas las funciones
    module.exports={
        query: (text, params) => pool.query(text, params)
    }