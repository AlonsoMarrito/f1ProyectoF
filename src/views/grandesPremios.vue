<template>
  <div>
    <div class="vistasVisibles">
      <section class="contenidoBarraDeNavegacion">
        <div class="espacioBarraNavegación">Grandes premios</div>
      </section>
      <section class="contenidoBarraDeNavegacion">
        <input type="text" class="textInputpuntosPiloto" ref="nombre_del_gp" id="piloto" placeholder="Nombre del gp">
        <input type="text" class="textInputpuntosPiloto" ref="numero_de_piloto" id="puntos" placeholder="Numero del piloto">
        <input type="text" class="textInputpuntosPiloto" ref="posicion_en_gp" id="puntos" placeholder="Posicion final">
      </section>
    </div>
    <button @click="verTablaGrandesPremios">Ver Grandes Premios</button>
    <button @click="agregarGranPremio">Agregar</button>

    <table v-if="pilotos.length > 0">
      <thead>
        <tr>
          <th>Nombre del Gran Premio</th>
          <th>Número de Carrera</th>
          <th>Número de Piloto</th>
          <th>Lugar por GP</th>
          <th>Acciones</th> <!-- Nueva columna para el botón de borrar -->
        </tr>
      </thead>
      <tbody>
        <tr v-for="(piloto, index) in pilotos" :key="index">
          <td>{{ piloto.nombre_del_gran_premio }}</td>
          <td>{{ piloto.numero_de_carrera }}</td>
          <td>{{ piloto.numero_de_piloto }}</td>
          <td>{{ piloto.lugar_por_gp }}</td>
          <td>
            <!-- Botón de borrar -->
            <button @click="eliminarGranPremio(piloto.id_del_registro)">Borrar GP</button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      pilotos: [],  // Este array almacenará los datos de la API
    };
  },
  methods: {
    async verTablaGrandesPremios() {
      console.log("presionado");
      try {
        const options = {
          url: 'http://localhost:3000/api/garndesPremios',  
          method: 'GET',
          headers: { 'Content-Type': 'application/json' },
        };
        const response = await axios.request(options);
        
        // Asignamos solo los datos que necesitamos, sin el id_del_registro
        this.pilotos = response.data.map(piloto => {
          return {
            nombre_del_gran_premio: piloto.nombre_del_gran_premio,
            numero_de_carrera: piloto.numero_de_carrera,
            numero_de_piloto: piloto.numero_de_piloto,
            lugar_por_gp: piloto.lugar_por_gp,
            id_del_registro: piloto.id_del_registro
          };
        });

        console.log(this.pilotos);
      } catch (err) {
        console.error('Error al hacer la solicitud:', err);
      }
    },
    async eliminarGranPremio(id_del_registro) {
      console.log("presionado");
      try {
        const options = {
          url: `http://localhost:3000/api/gp/${id_del_registro}`, 
          method: 'DELETE',
          headers: { 'Content-Type': 'application/json' },
        };
        const response = await axios.request(options);
        response.data;

        // Recargamos la tabla después de eliminar un gran premio
        this.verTablaGrandesPremios();
      } catch (err) {
        console.error('Error al hacer la solicitud:', err);
      }
    },
    async agregarGranPremio() {
      console.log("presionado");
      try {
          const nombre_del_gp = this.$refs.nombre_del_gp.value;
          const numero_de_piloto = this.$refs.numero_de_piloto.value;
          const posicion_en_gp = this.$refs.posicion_en_gp.value;

        const options = {
          url: `http://localhost:3000/api/GranPremio/${nombre_del_gp}/${numero_de_piloto}/${posicion_en_gp}`, 
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
        };
        const response = await axios.request(options);
        response.data;

        this.$refs.nombre_del_gp.value = '';
        this.$refs.numero_de_piloto.value = '';
        this.$refs.posicion_en_gp.value = '';
        
        // Recargamos la tabla después de agregar un gran premio
        this.verTablaGrandesPremios();
      } catch (err) {
        console.error('Error al hacer la solicitud:', err);
      }
    },
  },
};
</script>

<style scoped>
.espacioBarraNavegación {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 20px;
  color: #333;
}

table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
  background-color: #f9f9f9;  /* Fondo gris claro */
}

th, td {
  border: 1px solid #ddd;
  padding: 10px;
  text-align: left;
  color: black;  /* Color de texto negro en todas las celdas */
}

th {
  background-color: #4CAF50;  /* Fondo verde para los encabezados */
  color: white;  /* Texto blanco en los encabezados */
}

tr:nth-child(even) {
  background-color: #f2f2f2;  /* Fondo gris claro para filas pares */
}

tr:hover {
  background-color: #ddd;  /* Color gris oscuro al pasar el ratón */
}

button {
  margin: 20px 0;
  padding: 10px 15px;
  background-color: #4CAF50;
  color: white;
  border: none;
  margin-right: 10px;
  cursor: pointer;
}

button:hover {
  background-color: #45a049;
}

.vistasVisibles{
  flex-direction: column;
  height: 70px;
}

.textInputpuntosPiloto{
  margin-left: 5px;
  margin-right: 5px;
  text-align: center;
}
</style>
