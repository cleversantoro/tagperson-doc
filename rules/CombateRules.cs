using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TagPerson.Domain.ValueObjects
{
    internal class CombateRules
    {
    }


    public enum GrupoArma
    {
        CombateDesarmado,
        CombateImobilizacao,
        CorteLeve,
        CorteLeveDistancia,
        EsmagamentoLeve,
        CorteMedioEspadas,
        CorteMedioMachados,
        EsmagamentoMedio,
        PenetracaoMediaArcos,
        PenetracaoMediaLancas,
        CortePesadoEspadas,
        CortePesadoMachados,
        EsmagamentoPesado,
        PenetracaoPesada,
    }

    public static class CombateProfissaoSeed
    {
        public static int PontosPorEstagio(Profissao profissao) => profissao switch
        {
            Profissao.Bardo => 3,
            Profissao.Guerreiro => 10,
            Profissao.Ladino => 7,
            Profissao.Mago => 1,
            Profissao.Rastreador => 5,
            Profissao.Sacerdote => 5,
            _ => 0
        };
    }

    public class GrupoArmaPersonagem
    {
        public GrupoArma Grupo { get; init; }
        public int Nivel { get; private set; }

        public void AumentarNivel(int qtd) => Nivel += qtd;
    }

    public class Arma
    {
        public string Nome { get; init; }
        public GrupoArma Grupo { get; init; }
        public int ForcaMinima { get; init; }
        public AtributoTipo AtributoBonus { get; init; }

        public int BonusL { get; init; }
        public int BonusM { get; init; }
        public int BonusP { get; init; }

        public int Dano25 { get; init; }
        public int Dano50 { get; init; }
        public int Dano75 { get; init; }
        public int Dano100 { get; init; }
    }


    public static class ArmasSeed
    {
        public static IReadOnlyList<Arma> Todas => new[]
        {
        new Arma
        {
            Nome = "Espada",
            Grupo = GrupoArma.CorteMedioEspadas,
            ForcaMinima = 1,
            AtributoBonus = AtributoTipo.Agilidade,
            BonusL = 3,
            BonusM = 0,
            BonusP = -3,
            Dano25 = 4,
            Dano50 = 8,
            Dano75 = 12,
            Dano100 = 16
        },
        new Arma
        {
            Nome = "Machado de Guerra",
            Grupo = GrupoArma.CortePesadoMachados,
            ForcaMinima = 1,
            AtributoBonus = AtributoTipo.Forca,
            BonusL = 0,
            BonusM = 3,
            BonusP = -2,
            Dano25 = 5,
            Dano50 = 10,
            Dano75 = 15,
            Dano100 = 20
        }
    };
    }

    public static class CombateService
    {
        public static int CalcularTotalArma(Arma arma, GrupoArmaPersonagem grupo, Atributos atributos)
        {
            var ajuste = arma.AtributoBonus switch
            {
                AtributoTipo.Agilidade => atributos.Agilidade,
                AtributoTipo.Forca => atributos.Forca,
                AtributoTipo.Percepcao => atributos.Percepcao,
                _ => 0
            };

            return grupo.Nivel + ajuste;
        }


        public static (int L, int M, int P) CalcularColunasAtaque(Arma arma, int totalArma)
        {
            return (
                totalArma + arma.BonusL,
                totalArma + arma.BonusM,
                totalArma + arma.BonusP
            );
        }

        public static (int d25, int d50, int d75, int d100) CalcularDano(Arma arma, int forca)
        {
            return (
                arma.Dano25 + forca,
                arma.Dano50 + forca,
                arma.Dano75 + forca,
                arma.Dano100 + forca
            );
        }

        public static void ValidarUsoArma(Arma arma, GrupoArmaPersonagem grupo, Personagem personagem)
        {
            if (grupo.Nivel <= 0)
                throw new Exception("Personagem não sabe usar esta arma.");

            if (grupo.Nivel > personagem.Estagio)
                throw new Exception("Nível do grupo maior que o estágio.");

            if (personagem.Atributos.Forca < arma.ForcaMinima)
                throw new Exception("Força insuficiente para usar a arma.");
        }

    }


    public class CalcularAtaqueUseCase
    {
        public AtaqueResultado Executar(Personagem personagem, string nomeArma)
        {
            var arma = ArmasSeed.Todas.First(a => a.Nome == nomeArma);
            var grupo = personagem.GruposArma
                .First(g => g.Grupo == arma.Grupo);

            CombateService.ValidarUsoArma(arma, grupo, personagem);

            var total = CombateService.CalcularTotalArma(arma, grupo, personagem.Atributos);

            var colunas = CombateService.CalcularColunasAtaque(arma, total);
            var dano = CombateService.CalcularDano(arma, personagem.Atributos.Forca);

            return new AtaqueResultado
            {
                Total = total,
                L = colunas.L,
                M = colunas.M,
                P = colunas.P,
                Dano25 = dano.d25,
                Dano50 = dano.d50,
                Dano75 = dano.d75,
                Dano100 = dano.d100
            };
        }
    }

    public class AtaqueResultado
    {
        public int Total { get; init; }
        public int L { get; init; }
        public int M { get; init; }
        public int P { get; init; }
        public int Dano25 { get; init; }
        public int Dano50 { get; init; }
        public int Dano75 { get; init; }
        public int Dano100 { get; init; }
    }



}
