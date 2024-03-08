# P1-M9

O código contido neste repositório representa o sistema de simulação. Este projeto foi construído conforme as [golang-standards](https://github.com/golang-standards/project-layout) [^1].

## Dependências:

Antes de continuar, é necessário instalar as dependências para a execução dos comandos abaixo. Acesse o [link](https://docs.docker.com/desktop/install/ubuntu/).

## Como rodar o sistema:

Abaixo estão as possíveis interações e as instruções de como realizá-las.

#### Rodar testes:

Aqui, todos os comandos necessários estão sendo abstraídos por um arquivo Makefile. Se você tiver curiosidade para saber o que o comando abaixo faz, basta conferir [aqui](https://github.com/Inteli-College/2024-T0002-EC09-G04/blob/main/backend/Makefile#L7).

###### Comando:

```shell
make test
```

###### Output:

```shell
[+] Running 2/2
 ✔ Network p1-m9_default     Created                                                                                                                                  0.1s 
 ✔ Container p1-m9-broker-1  Started                                                                                                                                  0.1s 
Running the tests
?       github.com/henriquemarlon/p1-m9/cmd/freezer     [no test files]
?       github.com/henriquemarlon/p1-m9/cmd/refrigerator        [no test files]
?       github.com/henriquemarlon/p1-m9/cmd/subscriber  [no test files]
=== RUN   TestGenerateFreezerPayload
--- PASS: TestGenerateFreezerPayload (0.00s)
=== RUN   TestConnectFreezerMQTT
--- PASS: TestConnectFreezerMQTT (0.00s)
=== RUN   TestFreezerMessageTransmissionAndQOS
    freezer_test.go:68: New message on topic /sectors: {"id":"57cfbe4f-7689-4668-ad73-40818e0d3ea5","type":"freezer","temperature":-29,"timestamp":"2024-03-08 11:14:43.27210963 -0300 -03 m=+0.010450153"}
--- PASS: TestFreezerMessageTransmissionAndQOS (2.01s)
=== RUN   TestGenerateRefrigeratorPayload
--- PASS: TestGenerateRefrigeratorPayload (0.00s)
=== RUN   TestConnectRefrigeratorMQTT
--- PASS: TestConnectRefrigeratorMQTT (0.00s)
=== RUN   TestRefrigeratorMessageTransmissionAndQOS
    refrigerator_test.go:68: New message on topic /sectors: {"id":"6db9b78f-5453-4559-a444-0e882fb74f9c","type":"refrigerator","temperature":11,"timestamp":"2024-03-08 11:14:45.284938156 -0300 -03 m=+2.023278679"}
--- PASS: TestRefrigeratorMessageTransmissionAndQOS (2.01s)
PASS
coverage: 87.5% of statements
ok      github.com/henriquemarlon/p1-m9/internal/domain/entity  4.032s  coverage: 87.5% of statements
[+] Running 2/2
 ✔ Container p1-m9-broker-1  Removed                                                                                                                                  0.2s 
 ✔ Network p1-m9_default     Removed 
```

> [!NOTE]
> - No meio do processo, é necessário subir um broker local para realizar os testes de transmissão de mensagens entre os tópicos.

#### Rodar a simulação:

Mais uma vez, todos os comandos necessários estão sendo abstraídos por um arquivo Makefile. Se você tiver curiosidade para saber o que o comando abaixo faz, basta conferir [aqui](https://github.com/Inteli-College/2024-T0002-EC09-G04/blob/main/backend/Makefile#L15C2-L15C7).

###### Comando:

```bash
make run
```

###### Output:

```shell
broker-1        | 1709907632: New connection from 172.29.0.3:54964 on port 1891.
broker-1        | 1709907632: New client connected from 172.29.0.3:54964 as station-4818599352286748591 (p2, c1, k30).
broker-1        | 1709907632: New connection from 172.29.0.4:43566 on port 1891.
broker-1        | 1709907632: New client connected from 172.29.0.4:43566 as station-5554683134450851365 (p2, c1, k30).
broker-1        | 1709907632: New connection from 172.29.0.5:47822 on port 1891.
broker-1        | 1709907632: New client connected from 172.29.0.5:47822 as subscriber (p2, c1, k30).
subscriber-1    | 11 [ALERT High Temperature - Refrigerator] 
subscriber-1    | refrigerator 6 [OK] 
subscriber-1    | -29 [ALERT Low Temperature - Freezer] 
subscriber-1    | 0 [ALERT Low Temperature - Refrigerator] 
subscriber-1    | 1 [ALERT Low Temperature - Refrigerator] 
subscriber-1    | freezer -17 [OK] 
subscriber-1    | refrigerator 8 [OK] 
subscriber-1    | 1 [ALERT Low Temperature - Refrigerator] 
subscriber-1    | -29 [ALERT Low Temperature - Freezer] 
subscriber-1    | refrigerator 4 [OK] 
subscriber-1    | freezer -20 [OK] 
subscriber-1    | 11 [ALERT High Temperature - Refrigerator] 
subscriber-1    | refrigerator 6 [OK] 
subscriber-1    | refrigerator 4 [OK] 
subscriber-1    | -11 [ALERT High Temperature - Freezer] 
subscriber-1    | refrigerator 6 [OK] 
subscriber-1    | refrigerator 4 [OK] 
subscriber-1    | refrigerator 5 [OK] 
subscriber-1    | refrigerator 8 [OK]
```

> [!NOTE]
>  - Este comando está subindo todos os serviços presentes no arquivo compose.yml. São eles, o broker local, a simulação e a api-test que está sendo usada, por hora apenas para mostrar o log do que está sendo transmitido pela simulação.

#### Rodar a visualização da cobertura de testes:

Novamente, todos os comandos necessários estão sendo abstraídos por um arquivo Makefile. Se você tiver curiosidade para saber o que o comando abaixo faz, basta conferir [aqui](https://github.com/Inteli-College/2024-T0002-EC09-G04/blob/main/backend/Makefile#L21).

###### Comando:

```bash
make coverage 
```

###### Output:
![output_coverage](https://github.com/Inteli-College/2024-T0002-EC09-G04/assets/89201795/59e8654d-26bc-4e6c-990a-d4c823f38973)

> [!NOTE]
>  - Este comando está criando, a partir do arquivo `coverage_sheet.md`, uma visualização da cobertura de testes nos principais arquivos Go.

[^1]: A estrutura de pastas escolhida para este projeto está de acordo com as convenções e padrões utilizados pela comunidade de desenvolvedores Golang.
