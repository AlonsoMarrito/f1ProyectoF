const express = require('express');
const cors = require('cors')
const app = express();
const path = require('path');
// Permite recibir informacion json mediante api
app.use(express.json()); 

// Habilitar CORS para todas las rutas
app.use(cors());

//importar el archivo
const funciones = require("./src/express/funciones"); // el punto se usa porque server y funciones estan al mismo nivel


/////////// Endpoints ///////////////

app.get("/api/pilotos", funciones.pilotos);//select
app.get("/api/garndesPremios", funciones.garndesPremios);//select
app.get("/api/piloto_byId/:id_piloto", funciones.piloto_byId);//select por id
app.get("/api/gp_byId/:id_piloto", funciones.gp_byId);//select por id
app.post("/api/piloto", funciones.piloto);//insertar
app.post("/api/GranPremio/:nombre_del_gp/:numero_de_piloto/:posicion_en_gp", funciones.GranPremio);//insertar
app.put("/api/puntos/sumar/:numero_de_piloto/:cantidad", funciones.sumarPuntosManual);//update
app.put("/api/puntos/restar/:numero_de_piloto/:cantidad", funciones.restarPuntosManual);//update
app.put("/api/NombreGp/:id_gp/:nvo_nombre", funciones.cambiarNombreGp);//update
app.delete("/api/gp/:id_gp", funciones.gp);//delete
app.delete("/api/piloto/:id_piloto", funciones.piloto);//delete


app.use(express.static(path.join(__dirname, 'dist')));

app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, 'dist', 'index.html'))
})

// puede ser puerto 8000, 8080 u 3000 se usa 3000 para manejar solo 8 en php 
app.listen(3000, (error)=>{
    console.log("Api lista en el puesto 3000")
});