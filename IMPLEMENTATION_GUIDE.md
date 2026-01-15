# Guia de Implementação - Inicialização Automática de Personagens

## Visão Geral

A nova funcionalidade `CharacterInitializationService` automatiza a criação de personagens, inicializando atributos, habilidades, técnicas de combate e magias baseado na **raça** e **profissão** selecionadas.

## Arquitetura

### 1. **ICharacterInitializationService** (Interface)
- Localização: `TagPerson.Application/Interfaces/ICharacterInitializationService.cs`
- Responsável por: Definir contrato para inicialização de personagens

### 2. **CharacterInitializationService** (Implementação)
- Localização: `TagPerson.Application/Services/CharacterInitializationService.cs`
- Responsável por:
  - Validar raça e profissão
  - Validar combinação raça/profissão
  - Inicializar atributos baseado na raça
  - Inicializar pontos baseado na profissão
  - Adicionar habilidades, técnicas de combate e magias

## Como Funciona

### Fluxo de Criação

```
1. Frontend envia CreateCharacterRequestDto com: Name, Player, Level, RaceId, ProfessionId
2. CharacterService.CreateAsync() é chamado
3. Personagem é criado no banco de dados
4. CharacterInitializationService.InitializeCharacterAsync() é acionado
5. Validações são realizadas (raça, profissão, combinação)
6. Atributos inicializados baseado na raça
7. Pontos inicializados baseado na profissão
8. Habilidades, técnicas de combate e magias são adicionadas
9. Mudanças são salvas no banco de dados
```

## Detalhes de Implementação

### Inicialização de Atributos

Os atributos são inicializados com um valor base + bônus da raça:

```csharp
const int baseAttributeValue = 3; // Você pode ajustar este valor

AttAgi = 3 + race.BonusAgi;
AttPer = 3 + race.BonusPer;
AttInt = 3 + race.BonusInt;
AttAur = 3 + race.BonusAur;
AttCar = 3 + race.BonusCar;
AttFor = 3 + race.BonusFor;
AttFis = 3 + race.BonusFis;
```

### Inicialização de Pontos

Os pontos vêm da profissão:

```csharp
PointsSkill = profession.SkillPoints ?? 10;    // Pontos de habilidades
PointsWeapon = profession.WeaponPoints ?? 5;   // Pontos de armas
PointsCombat = profession.CombatPoints ?? 10;  // Pontos de combate
PointsMagic = profession.SpellGroup > 0 ? 10 : 0; // Pontos de magia (se profissão usa magia)
```

### Defesas

Baseadas na profissão (`BasicDefense` e `Absorption`):

```csharp
BasicDefense:
- "Alto" = 4
- "Médio" = 2
- "Baixo" = 0

Absorption:
- "Alto" = 4
- "Médio" = 2
- "Baixo" = 0
```

### Habilidades, Técnicas de Combate e Magias

A implementação atual usa métodos placeholder que você precisa customizar:

- `GetDefaultSkillsByProfession(int professionId)` - Retorna IDs das habilidades padrão
- `GetDefaultCombatSkillsByProfession(int professionId)` - Retorna IDs das técnicas de combate
- `GetDefaultSpellsByProfession(int professionId)` - Retorna IDs das magias padrão

## Customização Necessária

### Option 1: Usar Dados do Banco

Se você tem tabelas que mapeiam profissões para habilidades/técnicas/magias:

```csharp
private async Task<List<int>> GetDefaultSkillsByProfessionAsync(int professionId, CancellationToken ct)
{
    return await _db.ProfessionSkills
        .Where(ps => ps.ProfessionId == professionId)
        .Select(ps => ps.SkillId)
        .ToListAsync(ct);
}
```

### Option 2: Dados Hardcoded (Atual)

```csharp
return professionId switch
{
    1 => new List<int> { 1, 2, 3 },      // Guerreiro
    2 => new List<int> { 4, 5, 6 },      // Ladino
    3 => new List<int> { 7, 8, 9 },      // Mago
    _ => new List<int>()
};
```

## Exemplo de Uso

### Frontend (já implementado em tagperson-web)

```typescript
// Abre modal com campos: nome, racaId, profissaoId
dialog.open(NewCharacterDialogComponent).afterClosed().subscribe(async (result) => {
  if (result) {
    await this.store.createNewWithDetails(
      result.nome, 
      result.racaId, 
      result.profissaoId
    );
  }
});
```

### Backend (CharactersController)

```csharp
[HttpPost]
[ProducesResponseType(typeof(CharacterSheetDto), StatusCodes.Status201Created)]
public async Task<IActionResult> Create([FromBody] CreateCharacterRequestDto req)
{
    var created = await _service.CreateAsync(req, HttpContext.RequestAborted);
    return CreatedAtAction(nameof(Sheet), new { id = created.Id }, created);
}
```

Quando `CreateAsync()` é chamado com RaceId e ProfessionId preenchidos, a inicialização ocorre automaticamente.

## Validações

O serviço realiza as seguintes validações:

1. ✅ RaceId e ProfessionId são fornecidos
2. ✅ Race com RaceId fornecido existe
3. ✅ Profession com ProfessionId fornecido existe
4. ✅ A combinação raça/profissão é válida (existe em `RaceProfessions`)

Se qualquer validação falhar, uma `InvalidOperationException` é lançada.

## Próximos Passos Recomendados

1. **Criar tabelas no banco de dados** (se necessário):
   - `ProfessionSkill` (ProfessionId, SkillId, Level)
   - `ProfessionCombatSkill` (ProfessionId, CombatSkillId, Level)
   - `ProfessionSpell` (ProfessionId, SpellId, Level)

2. **Implementar métodos de busca** nos repositórios para esses dados

3. **Testar combinações raça/profissão** para garantir que:
   - Todas as combinações válidas estão em `RaceProfessions`
   - Os dados de habilidades/técnicas/magias estão corretos

4. **Considerar adicionar regras adicionais**, como:
   - Equipamentos iniciais baseados na profissão
   - Atributos mínimos/máximos por raça
   - Bônus especiais por combinação raça/profissão

## Troubleshooting

### Erro: "Raça ou profissão inválida"
- Verifique se RaceId e ProfessionId existem no banco
- Verifique se estão sendo passados corretamente do frontend

### Erro: "A combinação de raça e profissão não é permitida"
- Verifique a tabela `RaceProfessions`
- Certifique-se de que o par (RaceId, ProfessionId) existe

### Personagem criado sem habilidades/técnicas
- Verifique se os métodos `GetDefaultSkillsByProfession`, `GetDefaultCombatSkillsByProfession` e `GetDefaultSpellsByProfession` retornam IDs válidos
- Verifique se os IDs existem nas tabelas `Skills`, `CombatSkills` e `Spells`

