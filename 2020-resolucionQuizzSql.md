# Quizz SQL 2020

**Nivel de dificulad**: Parcial

**Autor**: Adrián Meca

**Comisión**: 305

**Link**: https://github.com/adrianmeca/sqlquizz/blob/master/2020-resolucionQuizzSql.md

## Alcance

[TOC]

## Modelo: Banco de Sangre

![DER Banco de Sangre](./img/2020-DERBancoSangre.png)

## SELECT & JOIN

**Temas**: SELECT - WHERE - ORDER BY - INNER JOIN - LEFT JOIN

1. Listar los productos entregados a cada institución en los últimos 6 meses. Indicando, código y nombre de la institución, código y descripción del tipo de producto, nro de lote y cantidad en ml de producto. Ordenar por nombre de institución, descripción de tipo de producto y fecha y hora de entrega ascendente

   #### Resolución

   | dificultad                                 | importancia |
   | :----------------------------------------- | ----------: |
   | múltiples join con su respectivo on        |         0.5 |
   | condición de where (no importa el adddate) |        0.25 |
   | order by                                   |        0.25 |
   
   ```mysql
   select inst.cod_insti, inst.nombre_insti
     , tp.cod_tipo, tp.descripcion
     , prod.nro_lote, prod.cantidad_ml
   from producto prod
   inner join institucion inst
     on inst.cod_insti=prod.cod_insti
   inner join tipo_producto tp
     on prod.cod_tipo=tp.cod_tipo
   where prod.fecha_entrega > addate(now(), interval -6 month)
   order by inst.nombre_insti, tp.descripcion, prod.fecha_entrega, prod.hora_entrega;
   ```
   
   
   
2. Listar las extracciones realizadas por un profesional (use un nombre y apellido cualquiera de su base de datos) y los controles realizados, indicando, matricula, nombre y apellido, fecha y hora de extracción y de cada control indicar fecha y hora de control y resultado. Ordenar por fecha y hora de control descendentes. Elija un nombre de profesional cualquiera que tenga extracciones y controles.

   #### Resolución

   | dificultad                                   | importancia |
   | :------------------------------------------- | ----------: |
   | múltiple joins con su on                     |         0.2 |
   | join con multiples campos **(FK compuesta)** |         0.6 |
   | condición de where                           |         0.1 |
   | order by                                     |         0.1 |

   ```mysql
   select prof.matricula, prof.nomb_ape
     ,ext.fecha_extraccion, ext.hora_extraccion
     ,cont.fecha_control, cont.hora_control, cont.resultado
   from profesional prof
   inner join extraccion ext
     on prof.matricula=ext.matricula
   inner join control cont
     on ext.id_donante=cont.id_donante
     and ext.fecha_extraccion=cont.fecha_extraccion
     and ext.hora_extraccion=cont.hora_extraccion
   where prof.nomb_ape='Edward Elric'
   order by cont.fecha_control desc, cont.hora_control desc;
   ```

3. Listar para cada extracción de este año el donante, profesional, los productos obtenidos y a qué institución fueron entregados. Si de una donación no se obtuvieron productos deben mostrase igualmente. Indicar id_donante, grupo sanguineo, nombre y apellido del profesional, fecha de extracción, motivo de descarte (si no tiene debe indicarse "Sin descarte"), código y descripción del tipo de producto, nro de lote y cantidad de ml. Ordenar por cantidad descripción del tipo de producto ascendente y cantidad de ml descendente.

   #### Resolución

   | dificultad                | importancia |
   | :------------------------ | ----------: |
   | left join encadenados     |        0.45 |
   | múltiples joins con su on |        0.15 |
   | join con FK compuesta     |        0.25 |
   | condición de where        |        0.05 |
   | order by                  |        0.05 |
   | coalesce                  |        0.05 |

   ```mysql
   select don.id_donante, don.grupo_sanguineo, prof.nomb_ape
     , ext.fecha_extraccion, coalesce(ext.motivo_descarte, 'Sin descarte') motivo_descarte
     , tp.cod_tipo, tp.descripcion
     , prod.nro_lote, prod.cantidad_ml
     , ins.cod_insti, ins.nombre_insti
   from extraccion ext
   inner join donante don
     on ext.id_donante=don.id_donante
   inner join profesional prof
     on ext.matricula=prof.matricula
   left join producto prod
     on ext.id_donante=prod.id_donante
     and ext.fecha_extraccion=prod.fecha_extraccion
     and ext.hora_extraccion=prod.hora_extraccion
   left join tipo_prod tp
     on prod.cod_tipo=tp.cod_tipo
   left join institucion ins
     on prod.cod_insti=ins.cod_insti
   where ext.fecha_extraccion between '20200101' and '20201231'
   order by tp.descripcion, prod.cantidad_ml desc;
   ```

4. Listar los profesionales y para cada uno las extracciones realizadas este año. Si no realizó ninguna este año deberá mostrarse igualmente.
   Indicar, matricula, nombre y apellido, fecha y hora de extracción y grupo sanguineo. Ordenar por nombre y apellido del profesional alfabeticamente.

   #### Resolución

   | dificultad                                               | importancia |
   | :------------------------------------------------------- | ----------: |
   | left join con condicion de **subconjunto (no en where)** |         0.6 |
   | left join encadenados                                    |        0.35 |
   | order by                                                 |        0.05 |

   ```mysql
   select prof.matricula, prof.nomb_ape
     , ext.fecha_extraccion, ext.hora_extraccion
     , don.grupo_sanguineo
   from profesionales prof
   left join extracciones ext
     on prof.matricula=ext.matricula
     and ext.fecha_extraccion >= '20200101'
   left join donante don
     on ext.id_donante=don.id_donante
   order by prof.nomb_ape;
   ```

