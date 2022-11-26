# PIV-Project

## Sistema 1: Sistema de detección de piel

![output](https://user-images.githubusercontent.com/82904867/204086814-9f0599cc-36c9-4da4-a417-de64592ea4d7.png)


a.  Implementar un script (algo1) que analice las imágenes del conjunto de entrenamiento y genere
    un histograma modelo de los píxeles de piel.

b.  Implementar una función (algo2) que analice una imagen arbitraria y genere una máscara binaria
    indicando los píxeles de piel.

c. Implementar un script (algo3) que utilice la función algo2 para generar las máscaras de la
    detección de piel para un conjunto de imágenes. El conjunto de imágenes se define mediante un
    directorio “Images”. Durante el desarrollo del sistema se puede utilizar el directorio del conjunto
    de validación. Pero al final de la tercera sesión, este algoritmo se tendrá que utilizar con un
    nuevo directorio entregado para la evaluación final. Las máscaras se tienen que escribir en un
    directorio “Masks” con el mismo nombre que las imágenes procesadas.

d. Implementar un script (algo4) que compare las máscaras obtenidas para un conjunto de imágenes
    arbitrarias (directorio “Masks”) y con las máscaras ideales correspondientes (directorio
    “Masks-Ideal”) y que calcule el F-score.



