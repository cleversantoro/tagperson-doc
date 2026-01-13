using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TagPerson.Domain.ValueObjects
{
    internal class MagiaRules
    {
    }

    public enum EscolaMagia
    {
        Elemental,
        Mental,
        Divina,
        Natural,
        Necromantica
    }

    public enum TipoEfeitoMagia
    {
        Dano,
        Cura,
        Condicao,
        ModificadorAtributo
    }

    public class Magia
    {
        public string Nome { get; init; }
        public EscolaMagia Escola { get; init; }
        public int CustoEM { get; init; }
        public int Dificuldade { get; init; }
        public TipoEfeitoMagia TipoEfeito { get; init; }
        public int ValorBase { get; init; }
        public CondicaoCombate? Condicao { get; init; }
    }

    public static class EnergiaMagicaService
    {
        public static int CalcularEnergiaMagica(int aura) => aura * 5;

        public int EnergiaMagica { get; set; }

    }

    public static class MagiasSeed
    {
        public static IReadOnlyList<Magia> Todas => new[]
        {
        new Magia
        {
            Nome = "Bola de Fogo",
            Escola = EscolaMagia.Elemental,
            CustoEM = 5,
            Dificuldade = 20,
            TipoEfeito = TipoEfeitoMagia.Dano,
            ValorBase = 12
        },
        new Magia
        {
            Nome = "Curar Ferimentos",
            Escola = EscolaMagia.Divina,
            CustoEM = 4,
            Dificuldade = 15,
            TipoEfeito = TipoEfeitoMagia.Cura,
            ValorBase = 10
        },
        new Magia
        {
            Nome = "Paralisia",
            Escola = EscolaMagia.Mental,
            CustoEM = 6,
            Dificuldade = 18,
            TipoEfeito = TipoEfeitoMagia.Condicao,
            Condicao = CondicaoCombate.Imobilizado
        }
    };
    }

    public static class ConjuracaoService
    {
        public static int CalcularTotal(
            int misticismo,
            int intelecto,
            int rolagem)
        {
            return misticismo + intelecto + rolagem;
        }
    }

    public class ResolverMagiaUseCase
    {
        public ResultadoMagia Executar(Personagem conjurador, Personagem alvo, Magia magia, int rolagem)
        {
            if (conjurador.EnergiaMagica < magia.CustoEM)
                throw new Exception("Energia mágica insuficiente.");

            var total = ConjuracaoService.CalcularTotal(
                conjurador.Misticismo,
                conjurador.Atributos.Intelecto,
                rolagem);

            conjurador.EnergiaMagica -= magia.CustoEM;

            if (total < magia.Dificuldade)
                return ResultadoMagia.Falha();

            AplicarEfeito(magia, conjurador, alvo);

            return ResultadoMagia.Sucesso();
        }

        private void AplicarEfeito(Magia magia, Personagem conjurador, Personagem alvo)
        {
            switch (magia.TipoEfeito)
            {
                case TipoEfeitoMagia.Dano:
                    alvo.EnergiaFisica -= magia.ValorBase + conjurador.Atributos.Aura;
                    break;

                case TipoEfeitoMagia.Cura:
                    alvo.EnergiaFisica += magia.ValorBase;
                    break;

                case TipoEfeitoMagia.Condicao:
                    CondicaoService.Aplicar(
                        alvo,
                        magia.Condicao!.Value,
                        2);
                    break;
            }
        }


    }

    public class ResultadoMagia
    {
        public bool Sucesso { get; init; }

        public static ResultadoMagia Sucesso() => new() { Sucesso = true };

        public static ResultadoMagia Falha() => new() { Sucesso = false };
    }

    //TurnoService.ValidarAcao(conjurador, TipoAcao.ConjurarMagia);
    //TurnoService.ExecutarAcao(conjurador, TipoAcao.ConjurarMagia);

}
