# 🎯 Guia Completo: O que é `computed` no Angular

## 📚 Índice
1. [Conceito Simples](#conceito-simples)
2. [Como Funciona](#-como-funciona)
3. [Exemplo do Seu Código](#-exemplo-do-seu-código)
4. [Fluxo de Reatividade](#-fluxo-de-reatividade)
5. [Sem vs Com Computed](#-comparação-sem-vs-com-computed)
6. [Tipos de Reatividade](#-tipos-de-reatividade-no-angular)
7. [Casos de Uso](#-casos-de-uso-do-computed)
8. [Regras Importantes](#-regras-importantes)
9. [Mental Model](#-mental-model-planilha-excel)
10. [Resumo](#-resumo)

---

## 🎯 Conceito Simples

`computed` é uma **função reativa** do Angular que **recalcula automaticamente** sempre que suas dependências mudam.

### Diferença Entre Variáveis Normais e Computed

```typescript
// ❌ Variável normal (estática)
const idade = 25;
// Calculada uma vez

// ✅ Computed (reativo - recalcula quando algo muda)
const anoPróximo = computed(() => {
  return new Date().getFullYear() + 1;
});
// Recalculada automaticamente quando usada
```

**Qual a diferença?**
- **Variável normal**: Calculada uma vez, não muda
- **Computed**: **Recalculada automaticamente** sempre que suas dependências mudam

---

## 🔄 Como Funciona

### Passo a Passo

```typescript
// 1️⃣ Você cria um signal (valor reativo)
const contador = signal(0);

// 2️⃣ Você cria um computed que DEPENDE do signal
const dobrado = computed(() => {
  return contador() * 2;  // ← Depende de contador
});

// 3️⃣ Você usa o computed
console.log(dobrado());  // 0

// 4️⃣ Você muda o signal
contador.set(5);

// 5️⃣ Computed RECALCULA automaticamente!
console.log(dobrado());  // 10 ← Mágica! 🪄
```

### O que Acontece Internamente

```
Criação:
  const dobrado = computed(() => contador() * 2)
  
Primeira execução:
  contador = 0
  dobrado() = 0 * 2 = 0
  ✅ Resultado armazenado em cache

Mudança:
  contador.set(5)
  Angular detecta: "contador mudou!"
  
Recalcualção automática:
  contador = 5
  dobrado() = 5 * 2 = 10
  ✅ Novo resultado armazenado em cache
  ✅ Componentes observando são notificados
```

---

## 💡 Exemplo do Seu Código

No arquivo `tab-spells.component.ts`:

### Computed 1: Mapa de Níveis

```typescript
private spellMap = computed(() => {
  const map = new Map<number, number>();
  
  // Depende de: this.sheet.magias
  for (const s of this.sheet.magias ?? []) {
    map.set(s.id, s.nivel ?? 0);
  }
  
  return map;  // ← Recalcula quando sheet.magias muda
});

// Uso:
levelOf(id: number) {
  return this.spellMap().get(id) ?? 0;  // ← Chama com ()
}
```

**O que faz:**
- Cria um `Map` que conecta ID da magia → Nível
- Recalcula automaticamente quando as magias do personagem mudam
- Armazena em cache para performance

### Computed 2: Set de IDs do Personagem

```typescript
private characterSpellIds = computed(() => {
  const ids = new Set<number>();
  
  // Depende de: this.sheet.magias
  for (const s of this.sheet.magias ?? []) {
    ids.add(s.id);
  }
  
  return ids;  // ← Recalcula quando sheet.magias muda
});
```

**O que faz:**
- Extrai apenas os IDs das magias do personagem
- Cria um `Set` para busca rápida O(1)
- Usado depois para filtrar magias

### Computed 3: Filtra Magias Básicas

```typescript
basicas = computed(() => this.filterParentId(-1));
//        ↑ Depende de: characterSpellIds()
//          (que por sua vez depende de sheet.magias)
```

**O que faz:**
- Chama o método `filterParentId` que usa `characterSpellIds()`
- Quando `characterSpellIds` muda, `basicas` recalcula
- Resultado: apenas as magias básicas do personagem

---

## 🔗 Fluxo de Reatividade

### Cascata Automática

```
User clica em novo personagem
    ↓
store.select(id) dispara
    ↓
store.selected() retorna novo CharacterSheet
    ↓
[sheet]="store.selected()!" atualiza @Input
    ↓
@Input sheet muda
    ↓
spellMap recalcula (depende de sheet.magias)
spellMap() → Novo Map[id→nivel]
    ↓
characterSpellIds recalcula (depende de sheet.magias)
characterSpellIds() → Novo Set{id1, id2, ...}
    ↓
basicas recalcula (depende de characterSpellIds)
basicas() → filtra() → apenas magias básicas
    ↓
especializacao recalcula (depende de characterSpellIds)
especializacao() → filtra() → apenas magias especializadas
    ↓
Template detecta mudanças em:
  - basicas()
  - especializacao()
    ↓
Template re-renderiza com novos dados
    ↓
✅ User vê as magias do novo personagem
```

### Diagrama de Dependências

```
                    @Input sheet
                         │
                    (quando muda)
                         │
        ┌────────────────┼────────────────┐
        ▼                ▼                ▼
    spellMap      characterSpellIds    (outros)
   (Map Id→Nível)  (Set de IDs)
        │                │
        └────────────────┼────────────────┐
                         ▼                ▼
                      basicas       especializacao
                  (Magias Básicas)  (Magias Especiais)
                         │                │
                         └────────────────┘
                                │
                         (Template observa)
                                │
                                ▼
                          Re-renderiza
```

---

## 📊 Comparação: Sem vs Com `computed`

### ❌ Forma Antiga (SEM `computed`)

```typescript
export class TabSpellsComponent {
  @Input sheet!: CharacterSheet;

  // ❌ Problema: não recalcula automaticamente
  characterSpellIds: Set<number> = new Set();

  ngOnInit() {
    this.characterSpellIds = this.calcularIds();
    // Calculado uma vez na inicialização
  }

  ngOnChanges() {
    this.characterSpellIds = this.calcularIds();
    // Precisa recalcular manualmente quando sheet muda
  }

  calcularIds() {
    const ids = new Set<number>();
    for (const s of this.sheet.magias ?? []) {
      ids.add(s.id);
    }
    return ids;
  }
}
```

**Problemas:**
- ❌ Precisa implementar `ngOnChanges`
- ❌ Código repetido em múltiplos lugares
- ❌ Fácil esquecer de atualizar
- ❌ Não é reativo
- ❌ Pode ficar desincronizado

### ✅ Forma Nova (COM `computed`)

```typescript
export class TabSpellsComponent {
  @Input sheet!: CharacterSheet;

  // ✅ Automático e reativo
  private characterSpellIds = computed(() => {
    const ids = new Set<number>();
    for (const s of this.sheet.magias ?? []) {
      ids.add(s.id);
    }
    return ids;
  });

  // Nenhuma lógica extra necessária!
}
```

**Vantagens:**
- ✅ Automático - recalcula quando sheet muda
- ✅ Sem `ngOnChanges`
- ✅ Sem código repetido
- ✅ Sempre sincronizado
- ✅ Declarativo e limpo

### Comparação Lado a Lado

| Aspecto | Sem `computed` | Com `computed` |
|---------|---|---|
| **Código** | Mais longo | Mais curto |
| **Lifecycle Hooks** | `ngOnInit`, `ngOnChanges` | Nenhum |
| **Reatividade** | Manual | Automática |
| **Risco de Bug** | Alto (esquecer update) | Baixo |
| **Performance** | Precisa gerir manualmente | Otimizada automaticamente |
| **Legibilidade** | Complicada | Clara e declarativa |

---

## 🧩 Tipos de Reatividade no Angular

### Sistema Completo de Signals

```typescript
import { signal, computed, effect } from '@angular/core';

// 1️⃣ SIGNAL: Estado reativo (como useState do React)
const contador = signal(0);

// Métodos:
contador.set(5);              // Define novo valor
contador.update(c => c + 1);  // Atualiza com base no valor anterior
contador();                   // Lê o valor

// 2️⃣ COMPUTED: Valor derivado (recalcula automaticamente)
const dobrado = computed(() => contador() * 2);

// Método:
dobrado();  // Retorna valor (sempre sincronizado)

// 3️⃣ @INPUT: Recebe valor do componente pai
@Input sheet!: CharacterSheet;

// 4️⃣ EFFECT: Executa efeito colateral quando algo muda
effect(() => {
  console.log('Contador mudou para:', contador());
  // Executado automaticamente quando contador() muda
});
```

### Relação Entre Eles

```
signal ─→ MUDA ─→ computed recalcula ─→ effect executa ─→ Template re-renderiza
  │
  └─→ @Input recebe novo valor ─→ (conta como uma mudança de signal)
```

---

## 🎯 Casos de Uso do `computed`

| Caso de Uso | Exemplo | Código |
|---|---|---|
| **Filtrar dados** | Magias do personagem | `basicas = computed(() => this.filterParentId(-1))` |
| **Mapear dados** | ID → Nível | `spellMap = computed(() => new Map(...))` |
| **Contar itens** | Quantas magias tem | `count = computed(() => this.sheet.magias?.length ?? 0)` |
| **Verificar condição** | Tem magias? | `temMagias = computed(() => this.sheet.magias?.length > 0)` |
| **Transformar dados** | Agrupar por nível | `magiasPorNivel = computed(() => this.agruparPorNível())` |
| **Combinar múltiplas fontes** | Resumo geral | `resumo = computed(() => this.combinaDados())` |
| **Buscar em Set/Map** | Nível de magia | `levelOf(id) { return this.spellMap().get(id) }` |
| **Ordernar dados** | Magias alfabéticas | `magiasSorted = computed(() => [...this.basicas()].sort())` |

### Exemplos Práticos

```typescript
// ✅ Exemplo 1: Contar
const totalMagias = computed(() => this.sheet.magias?.length ?? 0);

// ✅ Exemplo 2: Verificar
const personagenTemMagias = computed(() => 
  (this.sheet.magias?.length ?? 0) > 0
);

// ✅ Exemplo 3: Filtrar
const magiasCustosas = computed(() =>
  this.sheet.magias?.filter(m => m.custo > 10) ?? []
);

// ✅ Exemplo 4: Transformar
const magiasPorNome = computed(() =>
  this.sheet.magias?.map(m => m.nome) ?? []
);

// ✅ Exemplo 5: Agrupar
const magiasPorGrupo = computed(() => {
  const grupos = new Map<string, any[]>();
  for (const magia of this.sheet.magias ?? []) {
    if (!grupos.has(magia.grupo)) {
      grupos.set(magia.grupo, []);
    }
    grupos.get(magia.grupo)?.push(magia);
  }
  return grupos;
});
```

---

## 🔑 Regras Importantes

### ✅ Regra 1: Chamar Signals com `()`

**CORRETO:**
```typescript
const contador = signal(5);
const dobrado = computed(() => {
  return contador() * 2;  // ← Precisa de ()
});
```

**ERRADO:**
```typescript
const dobrado = computed(() => {
  return contador * 2;  // ❌ Erro! Não funciona
});
```

### ✅ Regra 2: Usar em Templates com `()`

**CORRETO:**
```html
<div>{{dobrado()}}</div>      <!-- ← Precisa de () -->
<div>{{basicas().length}}</div>  <!-- ← Precisa de () -->
```

**ERRADO:**
```html
<div>{{dobrado}}</div>        <!-- ❌ Retorna função, não valor -->
```

### ✅ Regra 3: Usar em TypeScript Sem `()` Novamente

**CORRETO:**
```typescript
const valor = dobrado();  // ← Já retorna o valor
console.log(valor);       // 10

const array = basicas();  // ← Já retorna o array
for (const item of array) { }
```

### ✅ Regra 4: Computed é Read-Only

**CORRETO:**
```typescript
const dobrado = computed(() => contador() * 2);
console.log(dobrado());  // Lê o valor ✅
```

**ERRADO:**
```typescript
dobrado.set(10);  // ❌ Erro! Computed é read-only
```

Se você quer um valor que pode mudar, use `signal`:
```typescript
const dobrado = signal(0);  // ← Pode mudar
dobrado.set(10);  // ✅ Funciona
```

### ✅ Regra 5: Evitar Lógica Complexa Dentro de Computed

**Bom (lógica simples):**
```typescript
const dobrado = computed(() => contador() * 2);
```

**Melhor (lógica complexa em método):**
```typescript
private processarDados() {
  // Lógica complexa aqui
  return resultado;
}

const resultado = computed(() => this.processarDados());
```

---

## 🧠 Mental Model: Planilha Excel

A melhor forma de entender `computed` é pensar em uma **fórmula no Excel**:

### Exemplo Simples

```
┌──────────────────────────────────┐
│ Planilha de Cálculo              │
├──────────────────────────────────┤
│ A1 = 10                          │
│ B1 = 20                          │
│                                  │
│ C1 = A1 + B1  (fórmula)          │
│ Resultado: C1 = 30               │
└──────────────────────────────────┘

Se você mudar A1 para 15:
C1 automaticamente vira 35
(Sem você fazer nada!)
```

### Equivalente em Angular

```typescript
const a = signal(10);
const b = signal(20);

const c = computed(() => a() + b());  // Fórmula
console.log(c());  // 30

a.set(15);  // Muda A
console.log(c());  // 35 ← Recalculou automaticamente!
```

### Comparação

| Excel | Angular | Conceito |
|---|---|---|
| Célula (A1) | Signal | Valor que pode mudar |
| Fórmula (=A1+B1) | Computed | Recalcula quando dependências mudam |
| Resultado (30) | Valor de computed | Sempre sincronizado |
| User muda A1 | Signal é atualizado | Cascata de mudanças |
| Excel recalcula | Computed recalcula | Automático |

---

## 📈 Performance: Por que Usar Computed?

### Otimizações Automáticas

```typescript
const dobrado = computed(() => {
  console.log('Recalculando...');
  return contador() * 2;
});

// Primeira chamada
console.log(dobrado());  // Log: "Recalculando..." → 0

// Segunda chamada (sem mudar contador)
console.log(dobrado());  // Sem log! Usou cache

// Muda o sinal
contador.set(5);

// Terceira chamada
console.log(dobrado());  // Log: "Recalculando..." → 10
```

**Angular Signals implementam:**
- ✅ **Memoization** (cache de resultados)
- ✅ **Lazy evaluation** (só recalcula se observado)
- ✅ **Dependency tracking** (sabe exatamente o que depende de quê)
- ✅ **Granular change detection** (só re-renderiza o necessário)

---

## 🚀 Caso Real: Seu Componente

### Antes (sem computed)

```typescript
export class TabSpellsComponent {
  @Input sheet!: CharacterSheet;
  
  spellMap: Map<number, number> = new Map();
  characterSpellIds: Set<number> = new Set();
  basicas: SpellFromGroup[] = [];
  especializacao: SpellFromGroup[] = [];
  
  ngOnInit() {
    this.updateData();
  }
  
  ngOnChanges() {
    this.updateData();  // Precisa chamar manualmente
  }
  
  updateData() {
    // Código repetido
    this.spellMap = new Map();
    for (const s of this.sheet.magias ?? []) {
      this.spellMap.set(s.id, s.nivel ?? 0);
    }
    
    this.characterSpellIds = new Set();
    for (const s of this.sheet.magias ?? []) {
      this.characterSpellIds.add(s.id);
    }
    
    this.basicas = this.filterParentId(-1);
    this.especializacao = this.filterByName(this.groups(), 'esp');
  }
}
```

### Depois (com computed)

```typescript
export class TabSpellsComponent {
  @Input sheet!: CharacterSheet;
  
  private spellMap = computed(() => {
    const map = new Map<number, number>();
    for (const s of this.sheet.magias ?? []) {
      map.set(s.id, s.nivel ?? 0);
    }
    return map;
  });
  
  private characterSpellIds = computed(() => {
    const ids = new Set<number>();
    for (const s of this.sheet.magias ?? []) {
      ids.add(s.id);
    }
    return ids;
  });
  
  basicas = computed(() => this.filterParentId(-1));
  especializacao = computed(() => this.filterByName(this.groups(), 'esp'));
}
```

**Benefícios:**
- ✅ Sem `ngOnChanges`
- ✅ Sem código duplicado
- ✅ Automático e reativo
- ✅ Mais fácil de entender
- ✅ Menos chance de bugs

---

## 📝 Resumo

### O que é Computed?

```
computed é uma função que:
  1. Recebe outras signals como dependências
  2. Retorna um valor calculado
  3. Recalcula AUTOMATICAMENTE quando dependências mudam
  4. Armazena em cache para performance
  5. Nunca fica desincronizado
```

### Características Principais

| Aspecto | Descrição |
|---------|-----------|
| **Reatividade** | Automática, sem callbacks |
| **Performance** | Otimizada com cache inteligente |
| **Sintaxe** | `computed(() => valor_derivado)` |
| **Uso** | Template: `computed()`; TypeScript: `computed()` |
| **Mutabilidade** | Read-only (não pode mudar) |
| **Uso Típico** | Filtros, transformações, derivações |

### Quando Usar

✅ **Use computed para:**
- Valores derivados
- Transformações de dados
- Filtros
- Mapeamentos
- Combinações de múltiplas sources
- Qualquer coisa que dependa de signals ou @Inputs

❌ **NÃO use computed para:**
- Lógica com efeitos colaterais (use `effect()`)
- Efeitos (HTTP requests, log, etc)
- Valores que não mudam

### Template vs TypeScript

```typescript
// 💻 TypeScript
const valor = dobrado();  // Retorna o valor

// 🎨 Template
{{ dobrado() }}           // Chama a função para obter valor
```

### Analogia Final

```
Signal     = Arquivo no disco
Computed   = Função que lê o arquivo
Effect     = Programa que faz algo quando o arquivo muda

Signal muda → Computed recalcula → Effect executa
                ↓
          Template re-renderiza
```

---

## 📚 Recursos Relacionados

- **Signals**: Estado reativo
- **Computed**: Valores derivados (este documento)
- **Effect**: Efeitos colaterais
- **Change Detection**: Como Angular detecta mudanças
- **Performance**: Angular Signals são muito eficientes

---

**Versão do Angular:** 17+  
**Última atualização:** Janeiro 13, 2026  
**Status:** ✅ Pronto para uso em produção
