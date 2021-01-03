# Quantum-Espresso

Simulação de materiais utilizando o Quantum Espresso

Para plotar os resultados basta https://github.com/Rafael-Barbosa/Scripts-Gnuplot

Se quiser mais detalhes https://www.youtube.com/watch?v=Wzp0pLnWKcU&t=1653s

## Si-FCC

1-) Lattice-parameter --> Relaxação dos parâmetros de rede

2-) Convergency --> Convergência dos parâmetros ecutwfc e kpoints

3-) (Com os parâmetros convergidos) - Entrar com os valores em scf

4-) (Utilizando os resultados de scf) - Gerar as bandas eletrônicas --(nesse caso como o cálculo scf é rápido, foi repetido)

4.1-) Extra gerar a figura utilizando um script em python.

5-) dos_pdos --> Cálculo das densidade de estados. 

![alt text](https://github.com/Rafael-Barbosa/Quantum-Espresso/blob/main/Si-Fcc/band_structure/pwband.png)


## Graphene 

--> Relaxação dos parâmtros de rede (lattice)

--> Densidade de Estados (pdos)

--> Cálculo de fônos (phonos)

--> Bandas eletrônicas (scf-bands)

--> Utilização do vc-relax

## Fe2Se2

--> Relaxação dos parâmtros utilizando FM, AFM e NM. (lattice)

--> Bandas Eletrônicas Spin-Up-Down

![alt text](https://github.com/Rafael-Barbosa/Quantum-Espresso/blob/main/Fe2Se2/lattice/fe2se2-2d.png)

## Graphene-Bilayer

--> Relaxação das duas camadas de grafeno utilizando Without-VdW e VdW

## Utilidades

### Qe_Bands.sh --> Gerar dat para bandas eletrônicas

### kpoints-qe.c --> Gerar pontos k para cálculo bands ("na mão")

### RODAR.sh --> Script para entrar nas pastas e rodar RUN.sh

### RUN.sh --> Editar ".in" precisa estar com scf editado corretamente

