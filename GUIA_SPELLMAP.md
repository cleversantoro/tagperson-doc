# 🗺️ Guia Completo: O que é `spellMap`

## 📚 Índice
1. [Conceito Simples](#conceito-simples)
2. [Localização no Código](#localização-no-código)
3. [O que Faz](#-o-que-faz)
4. [Por Que Usar Map](#-por-que-usar-map)
5. [Visualização Prática](#-visualização-prática)
6. [Quando Recalcula](#-quando-recalcula)
7. [Exemplos em Contexto Real](#-exemplos-em-contexto-real)
8. [Tipos de Dados](#-tipos-de-dados)
9. [Comparação com Alternativas](#-comparação-com-alternativas)
10. [Performance](#-performance)
11. [Resumo](#-resumo)

---

## 📍 Conceito Simples

`spellMap` é um **`Map`** (estrutura de dados) que **conecta IDs de magias com seus níveis** no personagem.

É como um **dicionário/tradutor** que responde:
> "Qual é o nível da magia de ID 5?"
> Resposta: "Nível 1"

---

## 🔍 Localização no Código

**Arquivo:** `src/app/features/characters/components/tabs/spells/tab-spells.component.ts`

**Linhas:** ~27-33

```typescript
private spellMap = computed(() => {
  const map = new Map<number, number>();
  for (const s of this.sheet.magias ?? []) {
    map.set(s.id, s.nivel ?? 0);
  }
  return map;
});
```

---

## 📊 O que Faz

### Passo a Passo da Criação

```typescript
// 1️⃣ Cria um Map vazio
const map = new Map<number, number>();

// 2️⃣ Percorre as magias do personagem
for (const s of this.sheet.magias ?? []) {
  // 3️⃣ Para cada magia, adiciona ao Map
  map.set(s.id, s.nivel ?? 0);
  //      ↑      ↑
  //     Chave  Valor
}

// 4️⃣ Retorna o Map pronto
return map;
```

### Exemplo Prático

Imagine um personagem com essas magias:

```typescript
sheet.magias = [
  { id: 1, nome: "Conjuração", nivel: 2, custo: 5, grupo: 'Basica', ... },
  { id: 5, nome: "Fireball", nivel: 1, custo: 10, grupo: 'Especializacao', ... },
  { id: 8, nome: "Invisibilidade", nivel: 3, custo: 8, grupo: 'Especializacao', ... }
]
```

**O `spellMap` transforma isso em:**

```typescript
spellMap = Map {
  1 → 2,    // ID 1 tem nível 2
  5 → 1,    // ID 5 tem nível 1
  8 → 3     // ID 8 tem nível 3
}
```

### Visualização como Tabela

| ID da Magia | Nível |
|---|---|
| 1 | 2 |
| 5 | 1 |
| 8 | 3 |

---

## 🎯 Como é Usado

No mesmo componente, existe um método que **usa** `spellMap`:

```typescript
levelOf(id: number) {
  return this.spellMap().get(id) ?? 0;
}
```

### O que Faz

- **Recebe:** Um ID de magia
- **Procura:** No `spellMap` usando esse ID
- **Retorna:** O nível da magia
- **Se não encontrar:** Retorna 0 (default)

### Exemplos de Uso

```typescript
// No código TypeScript:
levelOf(1);   // Retorna 2
levelOf(5);   // Retorna 1
levelOf(8);   // Retorna 3
levelOf(99);  // Retorna 0 (não existe)

// No template HTML:
<td>{{levelOf(1)}}</td>   // Mostra: 2
<td>{{levelOf(5)}}</td>   // Mostra: 1
<td>{{levelOf(99)}}</td>  // Mostra: 0
```

### Cascata de Usos

```typescript
// Método que usa levelOf:
totalOf(spell: SpellFromGroup) {
  const level = this.levelOf(spell.id);  // ← Usa levelOf
  const cost = spell.cost ?? 0;
  return level * cost;  // Nível × Custo
}

// Exemplo:
// spell = { id: 5, nome: "Fireball", cost: 10, ... }
// levelOf(5) = 1
// totalOf(spell) = 1 × 10 = 10

// No template:
<td>{{totalOf(spell)}}</td>  // Mostra: 10
```

---

## 💡 Por Que Usar Map?

### ❌ Sem Map (Busca Lenta)

Se você procurasse direto no array toda vez:

```typescript
levelOf(id: number) {
  // Percorre TODA a lista procurando
  const spell = this.sheet.magias?.find(s => s.id === id);
  return spell?.nivel ?? 0;
}
```

**Problema:**
```
this.sheet.magias = [
  { id: 1, ... },    ← Verifica
  { id: 5, ... },    ← Verifica
  { id: 8, ... }     ← Verifica (encontrou!)
]

A cada chamada, pode percorrer vários itens
Tempo: O(n) - Linear
Se tiver 1000 magias: até 1000 comparações!
```

### ✅ Com Map (Busca Rápida)

Com o `spellMap`:

```typescript
levelOf(id: number) {
  // Busca DIRETA na chave
  return this.spellMap().get(id) ?? 0;
}
```

**Vantagem:**
```
spellMap = Map {
  1 → 2,
  5 → 1,
  8 → 3,
  ...
}

Busca: spellMap().get(5)
Resultado: 1 (instantâneo!)

Sempre O(1) - Tempo constante
Mesmo com 1000 magias: 1 busca rápida!
```

### Comparação de Performance

| Operação | Sem Map | Com Map |
|---|---|---|
| **Estrutura** | Array | Map |
| **Busca** | `.find()` | `.get()` |
| **Tempo** | O(n) - Linear | O(1) - Constante |
| **100 magias** | até 100 comparações | 1 comparação |
| **1000 magias** | até 1000 comparações | 1 comparação |
| **Adequado para** | Poucas magias | Muitas magias |

---

## 🗺️ Tipos de Dados

### Tipo Completo

```typescript
private spellMap = computed(() => {
  const map = new Map<number, number>();
  //              ↑         ↑
  //           Chave     Valor
  
  return map;
});
```

### Interpretação

```
Map<number, number>
  ↑       ↑
  |       └─ Tipo do Valor (nível da magia)
  └────────── Tipo da Chave (ID da magia)

Assim:
Map<ID, Nível>
```

### O que Significa

```typescript
map.set(5, 1)
      ↑  ↑
    ID Nível

// Lê-se: "A magia com ID 5 tem nível 1"
```

---

## 📊 Visualização Prática

### Fluxo Completo

```
┌─────────────────────────────────────────┐
│ Dados Originais (Array)                 │
├─────────────────────────────────────────┤
│ sheet.magias = [                        │
│   { id: 1, nome: "...", nivel: 2 },     │
│   { id: 5, nome: "...", nivel: 1 },     │
│   { id: 8, nome: "...", nivel: 3 }      │
│ ]                                       │
└─────────────────────┬───────────────────┘
                      │
                      │ spellMap (computed)
                      │ transforma em:
                      ▼
┌─────────────────────────────────────────┐
│ Map (Estrutura Transformada)            │
├─────────────────────────────────────────┤
│ Map {                                   │
│   1 → 2,                                │
│   5 → 1,                                │
│   8 → 3                                 │
│ }                                       │
└─────────────────────┬───────────────────┘
                      │
                      │ levelOf(id) busca
                      ▼
┌─────────────────────────────────────────┐
│ Resultado da Busca                      │
├─────────────────────────────────────────┤
│ levelOf(5) → 1                          │
│ levelOf(1) → 2                          │
│ levelOf(99) → 0 (não existe)            │
└─────────────────────────────────────────┘
```

### Comparação de Estruturas

```
ANTES (Array):
┌─────────────────────────┐
│ Ordenado (index 0,1,2)  │
├─────────────────────────┤
│ [0] { id: 1, nivel: 2 } │
│ [1] { id: 5, nivel: 1 } │
│ [2] { id: 8, nivel: 3 } │
└─────────────────────────┘
Busca: Percorre sequencial

DEPOIS (Map):
┌─────────────────────────┐
│ Indexado por ID         │
├─────────────────────────┤
│ [1] → 2                 │
│ [5] → 1                 │
│ [8] → 3                 │
└─────────────────────────┘
Busca: Acesso direto
```

---

## 🔄 Quando Recalcula

`spellMap` é um `computed`, então **recalcula automaticamente** quando suas dependências mudam.

### Dependências

```typescript
private spellMap = computed(() => {
  const map = new Map<number, number>();
  for (const s of this.sheet.magias ?? []) {  // ← Depende de: sheet.magias
    map.set(s.id, s.nivel ?? 0);
  }
  return map;
});

// Recalcula quando:
// 1. this.sheet muda
// 2. this.sheet.magias muda
// 3. Qualquer elemento em magias muda
```

### Exemplo de Recalcualção

```typescript
// SITUAÇÃO 1: Personagem selecionado muda
// User clica em novo personagem
store.select(5)  // Novo personagem
  ↓
@Input sheet muda  // Novo objeto
  ↓
spellMap recalcula  // Novo Map

// ANTES:
spellMap = Map { 1→2, 5→1, 8→3 }

// DEPOIS (novo personagem):
spellMap = Map { 2→1, 10→2 }  // Magias diferentes
```

### Timeline de Recalcualção

```
t=0  User clica em novo personagem
     │
     ├─→ store.select(id)
     │
     └─→ @Input sheet muda
         │
         ├─→ spellMap detecta: "sheet mudou!"
         │
         └─→ spellMap recalcula
             ├─→ Cria novo Map
             ├─→ Percorre novo sheet.magias
             ├─→ Popula com novos dados
             └─→ Retorna novo Map

t=X  spellMap pronto com novos dados
     Template pode usar levelOf() com novos valores
```

---

## 📈 Exemplos em Contexto Real

### Exemplo 1: Simples

```typescript
// Componente tem:
private spellMap = computed(() => {
  const map = new Map<number, number>();
  for (const s of this.sheet.magias ?? []) {
    map.set(s.id, s.nivel ?? 0);
  }
  return map;
});

// Método que usa:
levelOf(id: number) {
  return this.spellMap().get(id) ?? 0;
}

// Template chama:
<td>Nível: {{levelOf(5)}}</td>  // Mostra: Nível: 1
```

### Exemplo 2: Com Transformação

```typescript
// spellMap fornece os níveis
// totalOf() usa para calcular

totalOf(spell: SpellFromGroup) {
  const level = this.levelOf(spell.id);    // ← Usa spellMap
  const cost = spell.cost ?? 0;
  return level * cost;
}

// Exemplo:
// spell = { id: 5, nome: "Fireball", cost: 10 }
// levelOf(5) = 1 (do spellMap)
// totalOf(spell) = 1 × 10 = 10

// Template:
<td>Total: {{totalOf(spell)}}</td>  // Mostra: Total: 10
```

### Exemplo 3: Completo na Tabela

```html
<table>
  <tbody>
    @for (spell of basicas(); track spell.id) {
      <tr>
        <td>{{spell.name}}</td>
        <td>{{levelOf(spell.id)}}</td>           <!-- ← Usa spellMap -->
        <td>{{spell.cost ?? 0}}</td>
        <td>{{totalOf(spell)}}</td>              <!-- ← Usa levelOf -->
        <td>
          <button (click)="selectSpell(spell)">
            Info
          </button>
        </td>
      </tr>
    }
  </tbody>
</table>
```

---

## 🔗 Relacionamentos com Outros Computeds

```
@Input sheet (muda quando personagem é selecionado)
    │
    ├─→ spellMap recalcula
    │   (cria Map com níveis)
    │   │
    │   └─→ levelOf(id) usa para buscar nível
    │       │
    │       └─→ totalOf(spell) usa para calcular total
    │
    ├─→ characterSpellIds recalcula
    │   (cria Set com IDs)
    │   │
    │   └─→ filterParentId() usa para filtrar
    │
    └─→ basicas recalcula
        (filtra magias básicas do personagem)
        │
        └─→ Template mostra na tabela
```

---

## 🧮 Comparação com Alternativas

### Alternativa 1: Sem spellMap (Find)

```typescript
levelOf(id: number) {
  const spell = this.sheet.magias?.find(s => s.id === id);
  return spell?.nivel ?? 0;
}

// ❌ Problemas:
// - Busca lenta (O(n))
// - Sem cache
// - Recalcula a cada chamada
// - Ineficiente para muitas magias
```

### Alternativa 2: Com spellMap (Current)

```typescript
private spellMap = computed(() => {
  const map = new Map<number, number>();
  for (const s of this.sheet.magias ?? []) {
    map.set(s.id, s.nivel ?? 0);
  }
  return map;
});

levelOf(id: number) {
  return this.spellMap().get(id) ?? 0;
}

// ✅ Vantagens:
// - Busca rápida (O(1))
// - Com cache
// - Recalcula apenas quando sheet muda
// - Eficiente mesmo com muitas magias
```

### Alternativa 3: Com Signal Updater

```typescript
private spellMap = signal<Map<number, number>>(new Map());

ngOnInit() {
  effect(() => {
    const map = new Map<number, number>();
    for (const s of this.sheet.magias ?? []) {
      map.set(s.id, s.nivel ?? 0);
    }
    this.spellMap.set(map);
  });
}

// ⚠️ Funciona mas é mais verboso
// ✅ Computed é mais simples
```

---

## ⚡ Performance

### Análise de Complexidade

```
Criação do spellMap:
  - Percorre sheet.magias: O(n)
  - Adiciona ao Map: O(1) × n = O(n)
  - Total: O(n)
  - Feito APENAS quando sheet muda

Busca com levelOf:
  - Map.get(): O(1)
  - Sempre instantâneo
  - Não importa quantas magias tem

Total por render:
  - Sem Map: O(n) × quantidade de buscas
  - Com Map: O(1) × quantidade de buscas
  - Diferença significante para muitas magias
```

### Exemplo com Números

```
100 magias, 50 buscas por render:

❌ SEM Map:
  50 buscas × 50 comparações média = 2.500 operações

✅ COM Map:
  Criação: 100 operações (uma vez)
  50 buscas × 1 comparação = 50 operações
  Total: 150 operações

Ganho: 16× mais rápido!
```

---

## 📝 Resumo

### O que é

```
spellMap é um Map que:
  - Mapeia ID de magia → Nível da magia
  - É criado uma vez (computed)
  - Recalcula quando sheet muda
  - Oferece busca O(1) instantânea
```

### Como funciona

```
1. Personagem tem magias: [{ id: 1, nivel: 2 }, ...]
2. spellMap transforma em: Map { 1→2, ... }
3. levelOf(1) busca no Map: retorna 2
4. Rápido e eficiente
```

### Quando usar

```
✅ Use Map quando:
  - Precisa buscar por chave frequentemente
  - Quer O(1) em vez de O(n)
  - Tem muitos itens

❌ Evite Map quando:
  - Tem poucos itens (array é suficiente)
  - Não precisa de buscas frequentes
  - Precisa de ordem (use array + sort)
```

### Analogia Final

```
Array é como uma lista de compras:
  - Precisa ler tudo para encontrar algo
  - Lento se tiver muitos itens

Map é como um dicionário:
  - Procura pela primeira letra (chave)
  - Encontra instantaneamente
  - Perfeito para muitos itens
```

---

## 🎓 Conceitos Relacionados

- **Computed**: Recalcula automaticamente (explicado no GUIA_COMPUTED.md)
- **Signal**: Valor reativo (veja FLUXO_SELECAO_PERSONAGEM.md)
- **Set vs Map**: Set armazena só chaves, Map armazena chave-valor
- **O(1) vs O(n)**: Notação Big O para complexidade de tempo

---

**Versão do Angular:** 17+  
**Última atualização:** Janeiro 13, 2026  
**Status:** ✅ Pronto para uso em produção
