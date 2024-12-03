<template>
  <main>
    <div class="vistasVisibles">
      <section class="contenidoBarraDeNavegacion">
        <div class="espacioBarraNavegación">Pilotos</div>
      </section>
      <section class="contenidoBarraDeNavegacion">
        <input type="text" class="textInputpuntosPiloto" ref="piloto" id="piloto" placeholder="Numero de piloto">
        <input type="text" class="textInputpuntosPiloto" ref="puntos" id="puntos" placeholder="Numero de puntos">
      </section>
    </div>

    <button @click="verTabla">Presiona para ver la tabla</button>
    <button @click="sumarPuntos">Sumar puntos a piloto</button>
    <button @click="restarPuntos">Restar puntos a piloto</button>

    <div class="EspacioDatos">
      <table v-if="pilotos.length > 0">
        <thead>
          <tr>
            <th>ID Piloto</th>
            <th>Nombre</th>
            <th>Escudería</th>
            <th>Puntos</th>
          </tr>
        </thead>
        <tbody>
          <!-- Itera sobre los pilotos y genera una fila por cada uno -->
          <tr v-for="piloto in pilotos" :key="piloto.id_piloto">
            <td>{{ piloto.id_piloto }}</td>
            <td>{{ piloto.nombre }}</td>
            <td>{{ piloto.escuderia }}</td>
            <td>{{ piloto.puntos }}</td>
          </tr>
        </tbody>
      </table>

      <!-- Mensaje si no hay datos -->
      <p v-else>No hay datos para mostrar.</p>
    </div>
  </main>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      pilotos: [],
    };
  },
  methods: {
    async verTabla() {
      console.log("presionado");
      try {
        const options = {
          url: 'http://localhost:3000/api/pilotos',  
          method: 'GET',
          headers: { 'Content-Type': 'application/json' },
        };
        const response = await axios.request(options);
        this.pilotos = response.data;

        console.log(this.pilotos);
      } catch (err) {
        console.error('Error al hacer la solicitud:', err);
      }
    },
    async sumarPuntos() {
      console.log("presionado");
      try {
          const numeroPiloto = this.$refs.piloto.value;
          const numeroPuntos = this.$refs.puntos.value;

        const options = {
          url: `http://localhost:3000/api/puntos/sumar/${numeroPiloto}/${numeroPuntos}`, 
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
        };
        const response = await axios.request(options);
        response.data;

        this.$refs.piloto.value = '';
        this.$refs.puntos.value = '';
        
        // Ahora llamamos a verTabla correctamente con this
        await this.verTabla();  // Aquí utilizamos `this` para asegurarnos que se ejecuta correctamente
      } catch (err) {
        console.error('Error al hacer la solicitud:', err);
      }
    },
    async restarPuntos() {
      console.log("presionado");
      try {
          const numeroPiloto = this.$refs.piloto.value;
          const numeroPuntos = this.$refs.puntos.value;

        const options = {
          url: `http://localhost:3000/api/puntos/restar/${numeroPiloto}/${numeroPuntos}`, 
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
        };
        const response = await axios.request(options);
        response.data;

        this.$refs.piloto.value = '';
        this.$refs.puntos.value = '';
        
        // Aquí también usamos `this` para llamar a verTabla correctamente
        await this.verTabla();  // Aquí utilizamos `this` para asegurarnos que se ejecuta correctamente
      } catch (err) {
        console.error('Error al hacer la solicitud:', err);
      }
    },
  },
};

</script>

<style scoped>
/* Estilos para la tabla */
table {
  width: 100%;
  border-collapse: collapse;
}

table th, table td {
  border: 1px solid #ddd;
  padding: 12px;
  text-align: left;
  color: white; /* Aseguramos que el texto sea blanco para visibilidad */
}

table th {
  background-color: #FF6347; /* Rojo tomate para los encabezados */
}

table tr:nth-child(even) {
  background-color: #FF4500; /* Naranja oscuro para filas pares */
}

table tr:nth-child(odd) {
  background-color: #FF6347; /* Rojo tomate para filas impares */
}

table td {
  background-color: #FF6347; /* Rojo tomate para las celdas */
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

.vistasVisibles{
  display: flex;
  flex-direction: column;
}

.textInputpuntosPiloto{
  margin-left: 5px;
  margin-right: 5px;
  text-align: center;
}

button:hover {
  background-color: #45a049;
}
</style>
