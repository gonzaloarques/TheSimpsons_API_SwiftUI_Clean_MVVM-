Proyecto con SwiftUI y arquitectura limpia + MVVM (como indica Apple) para mostrar un listado (a través de API) de varios Simpsons.
Para simplificar la arquitectura, cada componente (o casi) tendrá la siguiente lógica:
- Fichero de modelos: Almacenamos los modelos DTO (es decir, los que son iguales al origen (API, json local, etc)) y también los modelos (visuales) para la vista (junto a sus transformaciones necesarias para la misma).
- Fichero de repositorio: Almacenamos las llamadas al origen de los datos (API, json local, etc).
- Fichero de VM (ViewModel): Encargado de hacer las llamadas que tiene almacenadas el repositorio, y almacenarlas en el modelo (visual) para entregárselo a la vista.
- Fichero de vista: Contiene toda la parte visual del componente, utilizando el modelo de datos (visual) para mostrar los datos.

Tengo otro proyecto igual a este, pero utilizando datos locales (JSON e imágenes), por lo que es más sencillo. Puedes investigar ese primero si necesitas simplicidad en un inicio.
