# 📚 Guia Passo a Passo: Criar uma Nova Aba no Personagem

## Objetivo
Criar uma nova aba que exiba informações específicas do personagem (ex: "Inventário", "História", "Características", etc.)

---

## 📊 Estrutura Atual das Abas

```
src/app/features/characters/
├── pages/
│   └── character-page.component.ts/html/scss  ← Orquestra todas as abas
│
├── components/
│   └── tabs/
│       ├── spells/               ← Aba de Magias
│       │   ├── tab-spells.component.ts
│       │   ├── tab-spells.component.html
│       │   └── tab-spells.component.scss
│       │
│       ├── skills/               ← Aba de Habilidades
│       │   ├── tab-skills.component.ts
│       │   ├── tab-skills.component.html
│       │   └── tab-skills.component.scss
│       │
│       ├── combat/               ← Aba de Combate
│       └── ... (outras abas)
```

---

## 🎯 Passo a Passo Completo

### **PASSO 1: Preparar os Dados no Modelo**

**Arquivo:** `src/app/core/models/character.models.ts`

Certifique-se que o tipo `CharacterSheet` contém os dados que você quer exibir:

```typescript
export interface CharacterSheet {
  id: number;
  nome: string;
  nivel: number;
  
  // ... outros dados ...
  
  // Exemplo: se for criar aba de "Características"
  caracteristicas: Traits;  // ← Já existe!
  
  // Exemplo: se for criar aba de "Inventário"  
  equipamentosIniciais: StartingEquipments[];  // ← Já existe!
  
  // Exemplo: se for criar aba de "História"
  historia?: string;  // ← Pode precisar adicionar
}
```

**Se precisar adicionar um novo campo:**
```typescript
export interface CharacterSheet {
  // ... campos existentes ...
  minhaNovaInfo?: string;  // Adicione aqui
}
```

---

### **PASSO 2: Criar a Pasta da Nova Aba**

**Ação:** Criar diretório

```
📁 src/app/features/characters/components/tabs/minha-aba/
```

**Substitua `minha-aba` pelo nome real** (ex: `inventario`, `historia`, `objetivos`)

---

### **PASSO 3: Criar o Componente TypeScript**

**Arquivo a criar:** `src/app/features/characters/components/tabs/minha-aba/tab-minha-aba.component.ts`

```typescript
import { Component, Input, computed, inject } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import { MatButtonModule } from '@angular/material/button';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { CharacterSheet } from '../../../../../core/models/character.models';

@Component({
  standalone: true,
  selector: 'app-tab-minha-aba',
  imports: [
    MatCardModule, 
    MatIconModule, 
    MatButtonModule, 
    MatFormFieldModule, 
    MatInputModule
  ],
  templateUrl: './tab-minha-aba.component.html',
  styleUrls: ['./tab-minha-aba.component.scss']
})
export class TabMinhaAbaComponent {
  // ✅ SEMPRE: receber o sheet como @Input
  @Input({ required: true }) sheet!: CharacterSheet;

  // 🔧 LOGIC: seus dados derivados (computed, signals, etc)
  dados = computed(() => {
    // Extrai/processa os dados que você quer mostrar
    return this.sheet.caracteristicas ?? null;
  });

  // 🎯 METHODS: ações do usuário (edit, delete, add, etc)
  fazer_algo() {
    console.log('Faço algo com os dados');
  }
}
```

---

### **PASSO 4: Criar o Template HTML**

**Arquivo a criar:** `src/app/features/characters/components/tabs/minha-aba/tab-minha-aba.component.html`

**Padrão básico:**

```html
<div class="wrap">
  <!-- Seção 1: Exibir dados principais -->
  <mat-card>
    <mat-card-title>Meu Título</mat-card-title>
    <mat-card-content>
      <!-- Seu conteúdo aqui -->
      <p>{{sheet.propriedade}}</p>
      
      <!-- Exemplo com @if -->
      @if (sheet.propriedade) {
        <div>Tem dados</div>
      } @else {
        <div>Sem dados</div>
      }
      
      <!-- Exemplo com @for -->
      @for (item of dados().items; track item.id) {
        <div>{{item.nome}}</div>
      }
    </mat-card-content>
  </mat-card>

  <!-- Seção 2: Formulário ou edição (opcional) -->
  <mat-card>
    <mat-card-title>Editar</mat-card-title>
    <mat-card-content>
      <mat-form-field appearance="outline">
        <mat-label>Campo</mat-label>
        <input matInput [value]="sheet.propriedade" />
      </mat-form-field>
      <button mat-raised-button (click)="fazer_algo()">Salvar</button>
    </mat-card-content>
  </mat-card>
</div>
```

---

### **PASSO 5: Criar os Estilos (Opcional)**

**Arquivo a criar:** `src/app/features/characters/components/tabs/minha-aba/tab-minha-aba.component.scss`

```scss
.wrap {
  display: flex;
  gap: 16px;
  padding: 16px;

  mat-card {
    flex: 1;
    min-width: 300px;
  }

  mat-card-title {
    margin-bottom: 12px;
  }

  mat-form-field {
    width: 100%;
    margin-bottom: 8px;
  }

  button {
    margin-top: 8px;
  }
}
```

---

### **PASSO 6: Registrar o Componente na Página**

**Arquivo a MODIFICAR:** `src/app/features/characters/pages/character-page.component.ts`

**Adicionar import:**
```typescript
// ... imports existentes ...
import { TabSpellsComponent } from '../components/tabs/spells/tab-spells.component';
import { TabMinhaAbaComponent } from '../components/tabs/minha-aba/tab-minha-aba.component';  // ← NOVO

@Component({
  standalone: true,
  selector: 'app-character-page',
  imports: [
    MatTabsModule, 
    MatCardModule,
    CharacterHeaderComponent,
    TabSpellsComponent,
    TabMinhaAbaComponent,  // ← NOVO (adicionar à lista)
    // ... outros componentes
  ],
  templateUrl: './character-page.component.html',
  styleUrl: './character-page.component.scss'
})
export class CharacterPageComponent {
  constructor(public store: CharacterStore) {}
}
```

---

### **PASSO 7: Adicionar a Aba no Template**

**Arquivo a MODIFICAR:** `src/app/features/characters/pages/character-page.component.html`

```html
<mat-tab-group>
  <!-- Abas existentes -->
  <mat-tab label="Atributos">
    <ng-template matTabLabel>
      <mat-icon>assessment</mat-icon> Atributos
    </ng-template>
    <app-tab-attributes [sheet]="store.selected()!"></app-tab-attributes>
  </mat-tab>

  <mat-tab label="Habilidades">
    <ng-template matTabLabel>
      <mat-icon>school</mat-icon> Habilidades
    </ng-template>
    <app-tab-skills [sheet]="store.selected()!"></app-tab-skills>
  </mat-tab>

  <!-- NOVA ABA -->
  <mat-tab label="Minha Aba">
    <ng-template matTabLabel>
      <mat-icon>favorite</mat-icon> Minha Aba
    </ng-template>
    <app-tab-minha-aba [sheet]="store.selected()!"></app-tab-minha-aba>
  </mat-tab>
  <!-- FIM NOVA ABA -->

  <!-- ... outras abas ... -->
</mat-tab-group>
```

---

## 🔍 Exemplo Prático: Criar Aba de "Características"

Vamos criar uma aba que mostra características do personagem (olhos, cabelo, pele, idade, etc).

### **Estrutura de Dados Existentes**

Abrir `src/app/core/models/character.models.ts`:

```typescript
export interface Traits {
  olhos?: string;
  cabelo?: string;
  pele?: string;
  idade?: number;
  peso?: number;
  altura?: number;
  aparencia?: string;
  personalidadeObjetivos?: string;
  historia?: string;
  pertences: Array<{ equipmentId: number; nome: string; quantidade?: number }>;
  dinheiro: Money;
}

export interface CharacterSheet {
  // ...
  caracteristicas: Traits;  // ← Já existe!
  // ...
}
```

✅ **Os dados já estão no modelo!**

### **Criar o Componente**

**Arquivo:** `src/app/features/characters/components/tabs/caracteristicas/tab-caracteristicas.component.ts`

```typescript
import { Component, Input } from '@angular/core';
import { MatCardModule } from '@angular/material/card';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { CharacterSheet } from '../../../../../core/models/character.models';

@Component({
  standalone: true,
  selector: 'app-tab-caracteristicas',
  imports: [MatCardModule, MatFormFieldModule, MatInputModule],
  templateUrl: './tab-caracteristicas.component.html',
  styleUrls: ['./tab-caracteristicas.component.scss']
})
export class TabCaracteristicasComponent {
  @Input({ required: true }) sheet!: CharacterSheet;

  get traits() {
    return this.sheet.caracteristicas ?? {};
  }
}
```

### **Criar o Template**

**Arquivo:** `src/app/features/characters/components/tabs/caracteristicas/tab-caracteristicas.component.html`

```html
<div class="wrap">
  <!-- Características Físicas -->
  <mat-card>
    <mat-card-title>Características Físicas</mat-card-title>
    <mat-card-content>
      <mat-form-field appearance="outline">
        <mat-label>Olhos</mat-label>
        <input matInput [value]="traits.olhos ?? ''" readonly />
      </mat-form-field>

      <mat-form-field appearance="outline">
        <mat-label>Cabelo</mat-label>
        <input matInput [value]="traits.cabelo ?? ''" readonly />
      </mat-form-field>

      <mat-form-field appearance="outline">
        <mat-label>Pele</mat-label>
        <input matInput [value]="traits.pele ?? ''" readonly />
      </mat-form-field>

      <div class="row">
        <mat-form-field appearance="outline">
          <mat-label>Idade</mat-label>
          <input matInput [value]="traits.idade ?? 0" readonly />
        </mat-form-field>

        <mat-form-field appearance="outline">
          <mat-label>Altura</mat-label>
          <input matInput [value]="traits.altura ?? 0" readonly />
        </mat-form-field>

        <mat-form-field appearance="outline">
          <mat-label>Peso</mat-label>
          <input matInput [value]="traits.peso ?? 0" readonly />
        </mat-form-field>
      </div>
    </mat-card-content>
  </mat-card>

  <!-- Personalidade e História -->
  <mat-card>
    <mat-card-title>Personalidade e História</mat-card-title>
    <mat-card-content>
      <mat-form-field appearance="outline" class="full-width">
        <mat-label>Aparência</mat-label>
        <textarea matInput rows="4" [value]="traits.aparencia ?? ''" readonly></textarea>
      </mat-form-field>

      <mat-form-field appearance="outline" class="full-width">
        <mat-label>Personalidade e Objetivos</mat-label>
        <textarea matInput rows="4" [value]="traits.personalidadeObjetivos ?? ''" readonly></textarea>
      </mat-form-field>

      <mat-form-field appearance="outline" class="full-width">
        <mat-label>História</mat-label>
        <textarea matInput rows="6" [value]="traits.historia ?? ''" readonly></textarea>
      </mat-form-field>
    </mat-card-content>
  </mat-card>
</div>
```

### **Criar os Estilos**

**Arquivo:** `src/app/features/characters/components/tabs/caracteristicas/tab-caracteristicas.component.scss`

```scss
.wrap {
  display: flex;
  flex-direction: column;
  gap: 16px;
  padding: 16px;

  mat-card {
    width: 100%;
  }

  mat-form-field {
    width: 100%;
    margin-bottom: 8px;

    &.full-width {
      width: 100%;
    }
  }

  .row {
    display: flex;
    gap: 8px;

    mat-form-field {
      flex: 1;
    }
  }
}
```

### **Registrar na Página**

**Modificar:** `src/app/features/characters/pages/character-page.component.ts`

```typescript
import { TabCaracteristicasComponent } from '../components/tabs/caracteristicas/tab-caracteristicas.component';

@Component({
  // ...
  imports: [
    // ... existentes ...
    TabCaracteristicasComponent,  // ← NOVO
  ],
  // ...
})
export class CharacterPageComponent {
  constructor(public store: CharacterStore) {}
}
```

### **Adicionar a Aba**

**Modificar:** `src/app/features/characters/pages/character-page.component.html`

```html
<mat-tab-group>
  <!-- ... outras abas ... -->

  <mat-tab label="Características">
    <ng-template matTabLabel>
      <mat-icon>person</mat-icon> Características
    </ng-template>
    <app-tab-caracteristicas [sheet]="store.selected()!"></app-tab-caracteristicas>
  </mat-tab>
</mat-tab-group>
```

---

## 📋 Checklist: Resumo dos Passos

### **Arquivos a CRIAR:**
- [ ] `src/app/features/characters/components/tabs/minha-aba/tab-minha-aba.component.ts`
- [ ] `src/app/features/characters/components/tabs/minha-aba/tab-minha-aba.component.html`
- [ ] `src/app/features/characters/components/tabs/minha-aba/tab-minha-aba.component.scss` (opcional)

### **Arquivos a MODIFICAR:**
- [ ] `src/app/features/characters/pages/character-page.component.ts` (adicionar import + imports array)
- [ ] `src/app/features/characters/pages/character-page.component.html` (adicionar `<mat-tab>` com `<app-tab-minha-aba>`)

### **Verificações Finais:**
- [ ] O dados estão em `CharacterSheet`? (verificar `character.models.ts`)
- [ ] O componente recebe `@Input sheet`?
- [ ] O componente está importado em `character-page.component.ts`?
- [ ] A aba está adicionada no `character-page.component.html`?
- [ ] Os imports do componente têm `MatModule` necessários?

---

## 🎨 Exemplo de Icons do Material para Abas

```typescript
// Alguns icons que você pode usar
<mat-icon>assessment</mat-icon>        // Atributos
<mat-icon>school</mat-icon>            // Habilidades
<mat-icon>auto_awesome</mat-icon>      // Magias
<mat-icon>sports_martial_arts</mat-icon> // Combate
<mat-icon>backpack</mat-icon>          // Inventário
<mat-icon>person</mat-icon>            // Características
<mat-icon>history</mat-icon>           // História
<mat-icon>notes</mat-icon>             // Notas
<mat-icon>favorite</mat-icon>          // Favoritos
<mat-icon>info</mat-icon>              // Informações
```

---

## 🔗 Fluxo de Dados da Nova Aba

```
User seleciona personagem
    ↓
store.select(id) dispara
    ↓
store.selected() = novo CharacterSheet
    ↓
[sheet]="store.selected()!" passa para aba
    ↓
@Input sheet recebe dados
    ↓
Template renderiza com dados do personagem
```

---

## ⚠️ Erros Comuns

| Erro | Solução |
|------|---------|
| **`@Input is undefined`** | Verifique se está usando `[sheet]="store.selected()!"` no template pai |
| **`Component not showing`** | Adicione o componente ao array `imports` do `character-page.component.ts` |
| **`Dados não atualizam ao trocar personagem`** | Use `@Input` e certifique-se de não cachear dados localmente |
| **`Styled elements não funcionam`** | Importe `MatModule` necessários (ex: `MatFormFieldModule`, `MatInputModule`) |
| **`Type 'null' is not assignable`** | Use `?.` (optional chaining) ao acessar propriedades |

---

## 📚 Estrutura Final Esperada

Depois de seguir todos os passos:

```
src/app/features/characters/
├── components/tabs/
│   ├── spells/
│   ├── skills/
│   ├── combat/
│   ├── minha-aba/              ← NOVA ABA
│   │   ├── tab-minha-aba.component.ts
│   │   ├── tab-minha-aba.component.html
│   │   └── tab-minha-aba.component.scss
│   └── ...
│
└── pages/
    └── character-page.component.ts   ← MODIFICADO
```

---

**Pronto!** Sua nova aba estará funcional e seguindo o mesmo padrão reativo das outras abas. 🚀

Dúvidas? Explique qual é a informação que quer exibir que posso ajudar com detalhes específicos!
