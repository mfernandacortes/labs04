#  Sistema de Gestión de Biblioteca - Lógica SQL Avanzada

Este repositorio contiene el diseño y la implementación de una base de datos para la gestión de préstamos bibliotecarios. El objetivo principal de este proyecto es demostrar el dominio de la integridad de datos y la automatización de procesos directamente en el motor de base de datos **MySQL**.

---

##  Stack Técnico
* **Motor de Base de Datos:** MySQL / MariaDB.
* **Lógica Programada:** Stored Procedures y Triggers.
* **Modelado:** Relacional (Autores, Géneros, Libros, Socios, Préstamos).

---

##  Implementaciones Destacadas (SQL Avanzado)

A diferencia de un diseño CRUD básico, este proyecto implementa lógica de negocio programada:

* **Automatización con Triggers:** * Se implementó el disparador `modif_libro`, el cual se activa automáticamente al insertar un nuevo préstamo. 
    * Este trigger actualiza el estado del libro a "No Disponible" y registra la fecha de salida, garantizando la consistencia de la información sin depender de la lógica del lenguaje de programación externo.

* **Procedimientos Almacenados (Stored Procedures):**
    * Inclusión de procedimientos como `insertar_autor`, diseñados para estandarizar la entrada de datos, proteger la integridad de los IDs autoincrementales y facilitar la escalabilidad del sistema.

* **Integridad Referencial:**
    * Estructura de tablas normalizada que vincula autores, géneros y libros, asegurando que no existan datos huérfanos y optimizando el almacenamiento.

---

##  Contenido del Repositorio
* `gestion_biblioteca_avanzado.sql`: Contiene el script completo de creación de tablas, triggers, procedimientos y un volcado de datos de prueba (Seeders) para verificar el funcionamiento de la lógica.

---
##  Notas de Desarrollo e Impacto Académico

Este proyecto fue diseñado originalmente en **2019** como el **Examen Integrador Final** para la cátedra de **Base de Datos II** de la carrera de **Desarrollo de Software** (Nivel Terciario).

Como docente titular de la materia, diseñé esta arquitectura de datos como un estándar de evaluación profesional. El objetivo fue desafiar a los futuros desarrolladores a implementar:

* **Lógica de negocio en el motor de DB:** Mediante el uso estratégico de Stored Procedures y Triggers.
* **Automatización de integridad:** Asegurando la consistencia de los datos en procesos de préstamos y devoluciones sin intervención del backend.
* **Normalización y Escalabilidad:** Estructurando un modelo relacional eficiente que sirve como base para sistemas de gestión complejos.
El material se comparte como referencia técnica sobre el diseño de arquitecturas de datos y la automatización de procesos a nivel de base de datos.
