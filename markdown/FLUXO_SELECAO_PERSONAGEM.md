# Fluxo de Seleção de Personagem e Filtragem de Itens

## 📋 Índice
1. [Visão Geral](#visão-geral)
2. [O Store Central](#1-o-store-central-characterstore)
3. [O Clique no Personagem](#2-o-clique-no-personagem)
4. [A Aba de Magias](#3-a-aba-de-magias-recebe-o-personagem)
5. [O Componente de Magias](#4-o-componente-de-magias-filtra-os-dados)
6. [Fluxo Completo](#-fluxo-completo-visualmente)
7. [Pontos-Chave](#-pontos-chave)

---

## Visão Geral

Este documento descreve como funciona o sistema reativo de seleção de personagem e filtragem de seus itens (magias, habilidades, etc.) na aplicação TagPerson.

O sistema utiliza **Angular Signals** e **Computed Values** para manter a reatividade automática - quando um personagem é selecionado, todos os componentes dependentes são atualizados instantaneamente.

---

## 1. O Store Central: CharacterStore

**Arquivo:** `src/app/core/services/character-store.service.ts`

### Código Principal

```typescript
export class CharacterStore {
  private readonly api: CharacterApiService;
  private readonly auth: AuthService;

  // Signal: armazena o ID do personagem selecionado
  private readonly _selectedId = signal<number | null>(null);
  readonly selectedId = computed(() => this._selectedId());

  // Computed: retorna o objeto completo do personagem selecionado
  readonly selected = computed(() => {
    const id = this._selectedId();
    return this._characters().find(c => c.id === id) ?? null;
  });

  constructor(api: CharacterApiService, auth: AuthService) {
    this.api = api;
    this.auth = auth;
    void this.load();
  }

  async select(id: number) {
    this._selectedId.set(id);  // Atualiza o ID selecionado
    const sheet = await this.api.getSheet(id);  // Busca os dados completos
    this.upsert(this.api.mapSheet(sheet), false);  // Atualiza a lista local
  }
}
```

### O que Acontece

- **`_selectedId`**: Um **signal** que armazena qual personagem está selecionado
- **`selected`**: Um **computed** que sempre retorna o objeto **completo** do personagem selecionado, incluindo:
  - ID
  - Nome, Nível, Raça, Profissão
  - **Magias** (array com todas as magias do personagem)
  - Habilidades, Equipamentos, etc.

- **`select(id)`**: Quando chamado:
  1. Atualiza `_selectedId` para o novo ID
  2. Busca os dados completos da API
  3. Atualiza o `selected` automaticamente (via computed)
  4. **Todos os componentes que observam `selected` são re-renderizados**

---

## 2. O Clique no Personagem

**Arquivo:** `src/app/features/characters/components/character-list/character-list.component.html`

### Código HTML

```html
<mat-nav-list>
  @for (c of filtered(); track c.id) {
    <a mat-list-item 
       (click)="store.select(c.id)" 
       [class.active]="store.selectedId() === c.id">
      <span>{{c.profissao}} </span>
      <span>{{c.nome}} </span>
      <span class="lvl"> Nível {{c.nivel}}</span>
    </a>
  }
</mat-nav-list>
```

### Fluxo de Interação

1. **User clica no personagem** → por exemplo, "Aragorn - Guerreiro"
2. **`(click)="store.select(c.id)"`** é disparado → passa o ID do personagem
3. **`store.select(5)`** é executado (assumindo ID = 5)
4. **`_selectedId.set(5)`** → muda o signal
5. **Cascata de Atualizações:**
   - `selectedId()` é recalculado
   - `selected()` é recalculado
   - Todos os componentes que observam `selected()` são notificados
   - **UI é atualizada automaticamente**

### Visual do Estado

```
ANTES DO CLIQUE
┌─ CharacterList ─────────────────┐
│  [ ] Aragorn - Guerreiro        │
│  [X] Legolas - Arqueiro         │  ← Selecionado
│  [ ] Gandalf - Mago             │
└─────────────────────────────────┘

APÓS CLICAR EM ARAGORN
┌─ CharacterList ─────────────────┐
│  [X] Aragorn - Guerreiro        │  ← Novo selecionado
│  [ ] Legolas - Arqueiro         │
│  [ ] Gandalf - Mago             │
└─────────────────────────────────┘
```

---

## 3. A Aba de Magias Recebe o Personagem

**Arquivo:** `src/app/features/characters/pages/character-page.component.html`

### Código HTML

```html
<mat-tab-group>
  <!-- Outras abas... -->
  
  <mat-tab label="Magias">
    <ng-template matTabLabel>
      <mat-icon>auto_awesome</mat-icon> Magias
    </ng-template>
    <!-- O sheet completo (com magias) é passado como @Input -->
    <app-tab-spells [sheet]="store.selected()!"></app-tab-spells>
  </mat-tab>
</mat-tab-group>
```

### O Que Acontece

1. **`store.selected()`** retorna o objeto **completo** do personagem:
   ```typescript
   {
     id: 5,
     nome: "Aragorn",
     magias: [
       { id: 1, nome: "Conjuração de Magia", nivel: 2, ... },
       { id: 5, nome: "Fireball", nivel: 1, ... },
       // ... mais magias
     ],
     habilidades: [...],
     // ... outros dados
   }
   ```

2. **`[sheet]="store.selected()!"`** passa esse objeto como `@Input` para `TabSpellsComponent`

3. **Quando `selected` muda:**
   - O signal é atualizado
   - Angular detecta a mudança no `@Input sheet`
   - O componente filho `TabSpellsComponent` é re-renderizado
   - O `@Input sheet` recebe os novos dados

---

## 4. O Componente de Magias Filtra os Dados

**Arquivo:** `src/app/features/characters/components/tabs/spells/tab-spells.component.ts`

### Código Completo

```typescript
import { Component, Input, computed, inject, signal } from '@angular/core';
import { CharacterSheet } from '../../../../../core/models/character.models';
import { RulesService } from '../../../../../core/services/rules.service';
import { SpellFromGroup, SpellGroupWithSpells } from '../../../../../core/models/spells.models';

@Component({
  selector: 'app-tab-spells',
  standalone: true,
  imports: [/* ... */],
  templateUrl: './tab-spells.component.html',
  styleUrls: ['./tab-spells.component.scss']
})
export class TabSpellsComponent {
  @Input({ required: true }) sheet!: CharacterSheet;

  private rules = inject(RulesService);
  private selectedSpell = signal<SpellFromGroup | null>(null);

  groups = this.rules.spellGroups;  // Todas as magias do sistema

  // Step 1: Mapeia o nível de cada magia do personagem
  private spellMap = computed(() => {
    const map = new Map<number, number>();
    for (const s of this.sheet.magias ?? []) {
      map.set(s.id, s.nivel ?? 0);
    }
    return map;
  });

  // Step 2: Extrai APENAS os IDs das magias do personagem
  private characterSpellIds = computed(() => {
    const ids = new Set<number>();
    for (const s of this.sheet.magias ?? []) {
      ids.add(s.id);  // Adiciona só o ID
    }
    return ids;
  });

  // Step 3: Filtra magias básicas
  basicas = computed(() => this.filterParentId(-1));
  
  // Step 4: Filtra magias de especialização
  especializacao = computed(() => this.filterByName(this.groups(), 'esp'));

  // Retorna o nível de uma magia específica
  levelOf(id: number) {
    return this.spellMap().get(id) ?? 0;
  }

  // Calcula o total (nível × custo)
  totalOf(spell: SpellFromGroup) {
    const level = this.levelOf(spell.id);
    const cost = spell.cost ?? 0;
    return level * cost;
  }

  selectSpell(spell: SpellFromGroup) {
    this.selectedSpell.set(spell);
  }

  selected() {
    return this.selectedSpell();
  }

  effectsText() {
    const effects = this.selectedSpell()?.effects ?? '';
    return effects ? effects.replaceAll('|', '\n') : '';
  }

  // FILTRO 1: Por nome (especialização)
  private filterByName(groups: SpellGroupWithSpells[], hint: string) {
    const lowered = hint.toLowerCase();
    const characterIds = this.characterSpellIds();  // IDs do personagem

    const list = groups.filter(g => 
      g.group.name.toLowerCase().includes(lowered)
    );

    if (list.length > 0) {
      // Filtra: mostra APENAS magias que estão em characterIds
      return list.flatMap(g => g.spells)
        .filter(s => characterIds.has(s.id));  // ← FILTRO AQUI
    }

    return groups.flatMap(g => g.spells)
      .filter(s => characterIds.has(s.id));  // ← FILTRO AQUI
  }

  // FILTRO 2: Por ID da categoria
  private filterParentId(parentId: number) {
    const groups = this.groups() ?? [];
    const characterIds = this.characterSpellIds();  // IDs do personagem

    const list = groups.filter(g => g.group.parentId === parentId);

    if (list.length > 0) {
      // Filtra: mostra APENAS magias que estão em characterIds
      return list.flatMap(g => g.spells)
        .filter(s => characterIds.has(s.id));  // ← FILTRO AQUI
    }

    return groups
      .filter(g => g.group.parentId === parentId)
      .flatMap(g => g.spells)
      .filter(s => characterIds.has(s.id));  // ← FILTRO AQUI
  }
}
```

### Como Funciona o Filtro

#### Exemplo: Personagem "Aragorn" tem apenas 2 magias

```typescript
// sheet.magias = [
//   { id: 1, nome: "Conjuração", nivel: 2 },
//   { id: 5, nome: "Fireball", nivel: 1 }
// ]

// characterSpellIds = Set { 1, 5 }
// Sistema tem: Set { 1, 2, 3, 4, 5, 6, 7, 8, ... } (todas as magias)

// ANTES (sem filtro): mostraria todas as magias { 1, 2, 3, 4, 5, 6, 7, 8 }
// DEPOIS (com filtro): mostra apenas { 1, 5 }

.filter(s => characterIds.has(s.id))
// Verifica: essa magia está em characterIds?
// Magia 1: Sim ✓
// Magia 2: Não ✗
// Magia 3: Não ✗
// Magia 4: Não ✗
// Magia 5: Sim ✓
// Magia 6: Não ✗
// ...
// Resultado: [ Magia 1, Magia 5 ]
```

---

## 📊 Fluxo Completo (Visualmente)

### Diagrama do Fluxo Reativo

```
┌──────────────────────────────────────────────────────────────────┐
│  1. USER CLICA NO PERSONAGEM                                     │
│     (ex: "Aragorn - Guerreiro")                                  │
└────────────┬─────────────────────────────────────────────────────┘
             │
             ▼
┌──────────────────────────────────────────────────────────────────┐
│  2. CharacterListComponent                                       │
│     HTML: (click)="store.select(c.id)"                           │
│     Executa: store.select(5)  ← ID do Aragorn                    │
└────────────┬─────────────────────────────────────────────────────┘
             │
             ▼
┌──────────────────────────────────────────────────────────────────┐
│  3. CharacterStore (Sinal/Reativo)                               │
│     _selectedId.set(5)  ← Muda o signal                          │
│     API.getSheet(5)  ← Busca dados da API                        │
│     Retorna: {                                                   │
│       id: 5,                                                     │
│       nome: "Aragorn",                                           │
│       magias: [                                                  │
│         { id: 1, nome: "Conjuração", nivel: 2 },                │
│         { id: 5, nome: "Fireball", nivel: 1 }                   │
│       ]                                                          │
│     }                                                            │
└────────────┬─────────────────────────────────────────────────────┘
             │
             ▼
┌──────────────────────────────────────────────────────────────────┐
│  4. Cascata de Computed (Reatividade)                            │
│     _selectedId muda                                             │
│       ↓                                                          │
│     selectedId() recalcula                                       │
│       ↓                                                          │
│     selected() recalcula (busca o personagem completo)           │
│       ↓                                                          │
│     NOTIFICA todos os @Inputs que dependem de selected()         │
└────────────┬─────────────────────────────────────────────────────┘
             │
             ▼
┌──────────────────────────────────────────────────────────────────┐
│  5. CharacterPageComponent                                       │
│     [sheet]="store.selected()!"                                  │
│     Detecta mudança no @Input                                    │
│     Passa novo sheet para TabSpellsComponent                     │
└────────────┬─────────────────────────────────────────────────────┘
             │
             ▼
┌──────────────────────────────────────────────────────────────────┐
│  6. TabSpellsComponent                                           │
│     @Input sheet (novo valor com magias do Aragorn)              │
│     characterSpellIds = computed() → Set { 1, 5 }                │
│     basicas = computed() → filtra only { 1, 5 }                  │
│     especializacao = computed() → filtra only { 1, 5 }           │
└────────────┬─────────────────────────────────────────────────────┘
             │
             ▼
┌──────────────────────────────────────────────────────────────────┐
│  7. RESULTADO NA TELA                                            │
│     ✓ Magias Básicas:                                            │
│       - Conjuração (Nível 2)                                     │
│     ✓ Magias de Especialização:                                  │
│       - Fireball (Nível 1)                                       │
│                                                                  │
│     (Todas as outras magias do sistema não aparecem)             │
└──────────────────────────────────────────────────────────────────┘
```

### Timeline de Reatividade

```
TEMPO → →

t=0  User clica
     │
     ├─→ store._selectedId.set(5)
     │
     └─→ Muda o SIGNAL
          │
          ├─→ selectedId() recalcula
          │   └─→ Notifica observadores
          │
          ├─→ selected() recalcula
          │   └─→ Executa a busca (find)
          │       └─→ Retorna novo objeto
          │           └─→ Notifica observadores
          │
          └─→ Observador: CharacterPageComponent
              └─→ Detecta mudança no @Input
                  └─→ Passa novo sheet
                      └─→ TabSpellsComponent recebe
                          ├─→ characterSpellIds recalcula
                          ├─→ basicas recalcula
                          ├─→ especializacao recalcula
                          └─→ Template re-renderiza

t=X  Tela atualizada com magias do novo personagem
```

---

## 🔑 Pontos-Chave

| Conceito | Explicação | Exemplo |
|----------|-----------|---------|
| **Signal** | Variável reativa que notifica observadores quando muda | `_selectedId`, `_characters` |
| **Computed** | Valor derivado que recalcula quando suas dependências mudam | `selected()`, `characterSpellIds()` |
| **@Input** | Propriedade que recebe valores do componente pai | `@Input sheet` |
| **Reatividade** | Mudanças em cascata automática sem callbacks | Signal → Computed → @Input → Re-render |
| **Set** | Estrutura eficiente O(1) para verificar existência | `characterIds.has(s.id)` |
| **filter()** | Array function que reduz para elementos que atendem condição | `.filter(s => characterIds.has(s.id))` |

---

## 📝 Resumo Final

### Qual é a Mágica?

```typescript
// 1. User clica
store.select(id)

// 2. Signal muda
_selectedId.set(id)

// 3. Cascade automática
selected() → @Input → Component → Filtra dados

// 4. Resultado
Apenas dados do personagem aparecem na tela
```

### Por que funciona assim?

- **Angular Signals**: Fornecem reatividade automática
- **Computed Values**: Garantem que valores derivados sempre estejam sincronizados
- **Change Detection**: Angular detecta mudanças nos @Inputs e re-renderiza
- **Data Filtering**: O componente filho filtra o `sheet` para mostrar apenas itens relevantes

### Benefícios

✅ Sem callbacks manuais  
✅ Sem memory leaks  
✅ Código limpo e declarativo  
✅ Performance otimizada (change detection granular)  
✅ Fácil de entender o fluxo  

---

## 📚 Arquivos Relacionados

- `src/app/core/services/character-store.service.ts` - Estado central
- `src/app/features/characters/components/character-list/character-list.component.ts` - Lista de personagens
- `src/app/features/characters/pages/character-page.component.ts` - Página principal
- `src/app/features/characters/components/tabs/spells/tab-spells.component.ts` - Aba de magias
- `src/app/core/models/character.models.ts` - Tipos e interfaces

---

**Última atualização:** Janeiro 13, 2026  
**Versão do Angular:** 17+  
**Padrão:** Angular Signals & Computed Values
