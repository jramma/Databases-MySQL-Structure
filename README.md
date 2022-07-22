# mysql-estructura
>> n1ejercicio1

-Relacion : un proveedor puede proveer más de una 
marca pero solo puede haber un proveedor por marca>> 

![n1e1](https://user-images.githubusercontent.com/107991714/180503925-aa5f714a-15ff-4e52-a759-446bd6554656.png)

En el workbench:
select p.id, p.nombre , g.marca from  proveedor p  left join gafa g on p.nif = g.proveidorDeMarca;
para que muestre marcas y proveedores que hay.
