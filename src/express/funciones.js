const conn = require('./conection');
const cors = require('cors');


//ver la tabla de pilotos y su puntuacion
async function pilotos(req, res) {
    try {
        const resultado = await conn.query("SELECT * FROM pilotos");
        if (resultado.rows.length === 0) {
            res.json({ mensajeError: "No se encontraron pilotos." });
        } else {
            res.json(resultado.rows);
        }
    } catch (error) {
        console.error("Error al obtener los pilotos:", error);
        res.status(500).json({ mensajeError: "Error al obtener los pilotos." });
    }
}

//ver la tabla de de grandes premios y los lugares y su puntuacion
async function garndesPremios(req, res){
    
    try{
        const resultado = await conn.query("SELECT * FROM gran_premio");
        res.json(resultado.rows); 
    }
    catch(error){
        res.json({mensajeError: "no jala"});     
    }
}

//funcion para la insercion de pilotos recibiendo numero, nombre y escuderia
async function piloto(req, res){
    
    try{
    const resultado = await conn.query("SELECT registro_de_pilotos(" + req.body.numero_de_piloto +", '"+ req.body.nombre_de_piloto +"', '"+ req.body.Escuderia + "')");
    res.json({mensaje: "exitoso"});
    }
    catch(error){
        res.json({mensajeError: "no jala carnal"});     
    }
}

//funcion para la insercion de pilotos recibiendo nombre del gp, numero y posicion

async function GranPremio(req, res){
    
    try{
    const resultado = await conn.query("SELECT resultado_gp('" + req.params.nombre_del_gp +"', "+ req.params.numero_de_piloto +", "+ req.params.posicion_en_gp + ")");
    res.json({mensaje: "exitoso"});
    }
    catch(error){
        res.json({mensajeError: "no jala carnal"});     
    }
}

//funcion para la sumar puntos en pilotos recibiendo, numero y puntos

async function sumarPuntosManual(req, res){
    
    try{
    const resultado = await conn.query("SELECT sumapuntos(" + req.params.numero_de_piloto +", "+ req.params.cantidad + ")");
    res.json({mensaje: "exitoso"});
    }
    catch(error){
        res.json({mensajeError: error});     
    }
}

//funcion para la restar puntos en pilotos recibiendo, numero y puntos

async function restarPuntosManual(req, res){
    
    try{
    const resultado = await conn.query("SELECT restapuntos(" + req.params.numero_de_piloto +", "+ req.params.cantidad + ")");
    res.json({mensaje: "exitoso"});
    }
    catch(error){
        res.json({mensajeError: "no jala carnal"});     
    }
}

//funcion para la actualizar nombre del gp

async function cambiarNombreGp(req, res){
    
    try{
    const resultado = await conn.query("SELECT actualizarNombreGp(" + req.params.id_gp +", '"+ req.params.nvo_nombre + "')");
    res.json({mensaje: "exitoso"});
    }
    catch(error){
        res.json({mensajeError: "no jala carnal"});     
    }
}

//borrar gp por id de de la carrera

async function gp(req, res){
    
    try{
    const resultado = await conn.query("SELECT eliminar_gp_porpiloto(" + req.params.id_gp + ")");
    res.json({mensaje: "exitoso"});
    }
    catch(error){
        res.json({mensajeError: "no jala carnal"});     
    }
}

//borrar piloto por id de del piloto

async function piloto(req, res){
    
    try{
    const resultado = await conn.query("SELECT eliminar_piloto_porid(" + req.params.id_piloto + ")");
    res.json({mensaje: "exitoso"});
    }
    catch(error){
        res.json({mensajeError: "SELECT eliminar_piloto_porid(" + req.params.id_piloto});     
    }
}

//selccionar piloto por id 

async function piloto_byId(req, res){
    
    try{
    const resultado = await conn.query("SELECT * FROM pilotos where id_piloto = " + req.params.id_piloto);
    res.json(resultado.rows); 
    }
    catch(error){
        res.json({mensajeError: "no jala carnal"});     
    }
}

//selccionar carrera por id 

async function gp_byId(req, res){
    
    try{
    const resultado = await conn.query("SELECT * FROM gran_premio where id_del_registro = " + req.params.id_gp);
    res.json(resultado.rows); 
    }
    catch(error){
        res.json({mensajeError: "no jala carnal"});     
    }
}


// necesito exportar la funcion
module.exports={piloto, GranPremio, pilotos, sumarPuntosManual, restarPuntosManual, gp, garndesPremios, piloto_byId, gp_byId, 
    cambiarNombreGp, piloto};