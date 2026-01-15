# Guia - Sistema de Distribuição de Atributos por Pontos

## Visão Geral

O sistema de distribuição de atributos segue regras específicas onde o jogador recebe pontos para gastar na distribuição dos 7 atributos (Agilidade, Aura, Carisma, Físico, Força, Intelecto e Percepção).

## Regras Fundamentais

### 1. Pontos Iniciais
- **Base**: 15 pontos para todas as raças
- **Humanos**: 16 pontos (1 ponto bônus)

### 2. Valores Iniciais dos Atributos
- Todos começam com **0** mais o **ajuste racial**
- Cada raça tem bônus/penalidades específicas

**Exemplos:**
- Humano: +0 em todos (começam em 0)
- Anão: +1 Força, +2 Físico, -1 Agilidade

### 3. Limites de Atributos
- **Máximo**: Valor inicial + 4
- **Mínimo**: Valor inicial - 2

**Exemplos:**
- Humano com Força inicial 0 → Máximo 4, Mínimo -2
- Anão com Agilidade inicial -1 → Máximo 3, Mínimo -3

### 4. Custo para Aumentar Atributos
- Cada incremento custa um valor igual ao nível para o qual está indo
- **Exceção**: De valores negativos para 0 sempre custa 1 ponto

**Exemplo I - Humano com Força 3:**
```
Força inicial: 0
0 → 1: custa 1 ponto
1 → 2: custa 2 pontos
2 → 3: custa 3 pontos
Total: 1 + 2 + 3 = 6 pontos
```

**Exemplo II - Anão com Agilidade 3 (inicial -1):**
```
Agilidade inicial: -1
-1 → 0: custa 1 ponto (exceção: negativo)
0 → 1: custa 1 ponto
1 → 2: custa 2 pontos
2 → 3: custa 3 pontos
Total: 1 + 1 + 2 + 3 = 7 pontos
```

### 5. Custo para Reduzir Atributos
- Cada redução rende **0.5 pontos**
- Precisa reduzir **2 níveis** para ganhar **1 ponto** inteiro
- Valor mínimo é o **valor inicial - 2**

**Exemplo - Elfo Dourado reduzindo Agilidade:**
```
Agilidade inicial: +1
1 → 0: ganha 0.5 ponto
0 → -1: ganha 0.5 ponto
Total ganho: 1 ponto (1 nível = 0.5, 2 níveis = 1 ponto)
Agilidade não pode ir abaixo de -1 (inicial -2)
```

## Endpoints da API

### 1. Validar Distribuição de Atributos
Valida uma distribuição **sem aplicá-la**.

```
POST /api/characters/{id}/validate-attributes
Content-Type: application/json

{
  "attAgi": 2,
  "attPer": 3,
  "attInt": 2,
  "attAur": 1,
  "attCar": 2,
  "attFor": 3,
  "attFis": 2
}
```

**Resposta (200 OK):**
```json
{
  "finalValues": {
    "Agilidade": 2,
    "Percepcao": 3,
    "Intelecto": 2,
    "Aura": 1,
    "Carisma": 2,
    "Forca": 3,
    "Fisico": 2
  },
  "pointsUsed": [
    ["Agilidade", 3],
    ["Percepcao", 6],
    ["Intelecto", 3],
    ["Aura", 1],
    ["Carisma", 3],
    ["Forca", 6],
    ["Fisico", 3]
  ],
  "pointsGained": [],
  "totalPointsNeeded": 28,
  "totalPointsGained": 0,
  "netCost": 28,
  "isValid": false,
  "errors": [
    "Pontos insuficientes. Necessário: 28, Disponível: 15"
  ]
}
```

### 2. Aplicar Distribuição de Atributos
Aplica a distribuição **se for válida**.

```
POST /api/characters/{id}/apply-attributes
Content-Type: application/json

{
  "attAgi": 2,
  "attPer": 3,
  "attInt": 2,
  "attAur": 1,
  "attCar": 2,
  "attFor": 2,
  "attFis": 2
}
```

**Resposta (204 No Content):**
Atributos aplicados com sucesso

**Resposta (400 Bad Request):**
```json
{
  "message": "Pontos insuficientes. Necessário: XX, Disponível: YY"
}
```

## Classe: AttributeCalculationService

Serviço que realiza todos os cálculos.

### Métodos Principais

#### CalculateInitialPoints(Race race)
Retorna os pontos iniciais disponíveis.
```csharp
var points = service.CalculateInitialPoints(race);
// Humanos: 16, Outros: 15
```

#### GetInitialAttributeValue(AttributeType type, Race race)
Obtém o valor inicial de um atributo.
```csharp
var initial = service.GetInitialAttributeValue(AttributeType.Forca, race);
// Exemplo: Anão = +1
```

#### CalculateAttributeCost(int fromValue, int toValue, int initialValue)
Calcula o custo (ou ganho) de uma mudança de atributo.
```csharp
var cost = service.CalculateAttributeCost(0, 3, 0);
// Resultado: 6 (para humano: 1+2+3)
```

#### ValidateAttributeDistribution(Race race, Dictionary<AttributeType, int> desiredValues)
Valida uma distribuição completa.
```csharp
var (isValid, message) = service.ValidateAttributeDistribution(race, values);
if (!isValid)
    Console.WriteLine(message);
```

## Estrutura de Dados

### AttributeType (Enum)
```csharp
public enum AttributeType
{
    Agilidade,
    Aura,
    Carisma,
    Fisico,
    Forca,
    Intelecto,
    Percepcao
}
```

### AttributeDistributionResult
```csharp
public class AttributeDistributionResult
{
    public Dictionary<AttributeType, int> FinalValues { get; }
    public List<(AttributeType Type, int PointsUsed)> PointsUsed { get; }
    public List<(AttributeType Type, decimal PointsGained)> PointsGained { get; }
    public int TotalPointsNeeded { get; set; }
    public decimal TotalPointsGained { get; set; }
    public int NetCost { get; set; }
    public List<string> Errors { get; }
    public bool IsValid => !Errors.Any();
}
```

## Frontend Integration

### Angular Service
```typescript
validateAttributes(characterId: number, attributes: AttributeDistributionRequest): Observable<AttributeDistributionResponse> {
  return this.http.post<AttributeDistributionResponse>(
    `${this.apiUrl}/characters/${characterId}/validate-attributes`,
    attributes
  );
}

applyAttributes(characterId: number, attributes: AttributeDistributionRequest): Observable<void> {
  return this.http.post<void>(
    `${this.apiUrl}/characters/${characterId}/apply-attributes`,
    attributes
  );
}
```

### Componente Angular
```typescript
onAttributeChange(attributeType: string, newValue: number) {
  // Atualizar valor temporário
  this.tempAttributes[attributeType] = newValue;
  
  // Validar distribuição em tempo real
  this.characterService.validateAttributes(this.characterId, this.tempAttributes)
    .subscribe(result => {
      if (result.isValid) {
        this.showSuccess(`Distribuição válida! Pontos restantes: ${availablePoints - result.netCost}`);
      } else {
        this.showError(result.errors.join('; '));
      }
    });
}

onApplyAttributes() {
  this.characterService.applyAttributes(this.characterId, this.tempAttributes)
    .subscribe(
      () => this.showSuccess('Atributos aplicados com sucesso'),
      error => this.showError(error.error.message)
    );
}
```

## Exemplos Práticos

### Exemplo 1: Guerreiro Humano
```
Pontos disponíveis: 16
Distribuição desejada:
- Força: 3 → Custa 1+2+3 = 6
- Físico: 3 → Custa 1+2+3 = 6
- Agilidade: 1 → Custa 1 = 1
- Aura: 1 → Custa 1 = 1
- Carisma: 0 → Custa 0 = 0
- Intelecto: 0 → Custa 0 = 0
- Percepção: 1 → Custa 1 = 1

Total: 6+6+1+1+0+0+1 = 15 ✓ Válido (1 ponto restante)
```

### Exemplo 2: Sacerdote Anão com Redução
```
Pontos disponíveis: 15
Atributos iniciais (Anão): Agi -1, Aur +1, Car +0, Fis +2, For +1, Int +0, Per +0

Distribuição:
- Força: 2 (inicial 1) → Custa 2
- Agilidade: 2 (inicial -1) → Custa 1+1+2 = 4
- Aura: 3 (inicial 1) → Custa 2+3 = 5
- Carisma: 0 (inicial 0) reduz para -2 → Ganha 2 * 0.5 = 1 ponto

Total: 2+4+5 = 11 - 1 (ganho) = 10 ✓ Válido (5 pontos restantes)
```

## Ajustes Necessários

1. **Verificar IDs de Raças**: Confirmar qual é o ID da raça Humano (atualmente 1)
2. **Ajustar Bônus Raciais**: Confirmar todos os bônus/penalidades de cada raça
3. **Testar Cálculos**: Validar com exemplos reais do seu sistema
