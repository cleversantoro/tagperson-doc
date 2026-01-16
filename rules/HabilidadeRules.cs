using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TagPerson.Domain.ValueObjects;

namespace TagPerson.Domain.ValueObjects
{
    public enum GrupoHabilidade
    {
        Profissional,
        Manobra,
        Conhecimento,
        Subterfugio,
        Influencia,
        Geral
    }

    public enum AtributoTipo
    {
        Nenhum,
        Agilidade,
        Aura,
        Carisma,
        Fisico,
        Forca,
        Intelecto,
        Percepcao
    }

    internal class HabilidadeRules
    {
    }

    public class Habilidade
    {
        public string Nome { get; init; }
        public GrupoHabilidade Grupo { get; init; }
        public int CustoBase { get; init; }
        public AtributoTipo AtributoAssociado { get; init; }
        public bool Restrita { get; init; }
        public bool PossuiArea { get; init; }
    }

    public class HabilidadePersonagem
    {
        public Habilidade Habilidade { get; init; }
        public int Nivel { get; private set; }

        public void AumentarNivel(int quantidade)
        {
            Nivel += quantidade;
        }
    }

    public class ConfiguracaoProfissao
    {
        public Profissao Profissao { get; init; }
        public int PontosPorEstagio { get; init; }
        public GrupoHabilidade? GrupoPenalizado { get; init; }
        public string HabilidadeAperfeicoada { get; init; }


        //var guerreiro = new ConfiguracaoProfissao
        //{
        //    Profissao = Profissao.Guerreiro,
        //    PontosPorEstagio = 14,
        //    GrupoPenalizado = GrupoHabilidade.Influencia,
        //    HabilidadeAperfeicoada = "Aplicar Esforço"
        //};


    }

    public static class HabilidadeService
    {
        public static int CalcularCusto(Habilidade habilidade, ConfiguracaoProfissao profissao)
        {
            var custo = habilidade.CustoBase;

            if (profissao.GrupoPenalizado == habilidade.Grupo)
                custo += 1;

            return custo;
        }


        public static void ValidarNivel(int novoNivel, int estagio)
        {
            if (novoNivel > estagio)
                throw new InvalidOperationException("Nível da habilidade não pode ser maior que o estágio do personagem.");
        }


        public static int CalcularTotal(HabilidadePersonagem habilidade, Atributos atributos)
        {
            var ajuste = habilidade.Habilidade.AtributoAssociado switch
            {
                AtributoTipo.Agilidade => atributos.Agilidade,
                AtributoTipo.Aura => atributos.Aura,
                AtributoTipo.Carisma => atributos.Carisma,
                AtributoTipo.Fisico => atributos.Fisico,
                AtributoTipo.Forca => atributos.Forca,
                AtributoTipo.Intelecto => atributos.Intelecto,
                AtributoTipo.Percepcao => atributos.Percepcao,
                _ => 0
            };

            return habilidade.Nivel + ajuste;
        }

        public static int CalcularLimiteHabilidades(int pontosPorEstagio, int estagio)
        {
            var estagiosPares = estagio / 2;
            return pontosPorEstagio + estagiosPares;
        }

        public static bool EhAperfeicoada(Habilidade habilidade, ConfiguracaoProfissao profissao)
        {
            return habilidade.Nome == profissao.HabilidadeAperfeicoada;
        }

        //if (EhAperfeicoada(habilidade, profissao))
        //{
        //    habilidadePersonagem.AumentarNivel(1);
        //}

        //var custo = HabilidadeService.CalcularCusto(habilidade, profissao);

        //if (pontosDisponiveis<custo)
        //    throw new Exception("Pontos insuficientes");

        //HabilidadeService.ValidarNivel(habilidadePersonagem.Nivel + 1,personagem.Estagio);

        //habilidadePersonagem.AumentarNivel(1);

        //var total = HabilidadeService.CalcularTotal(habilidadePersonagem, personagem.Atributos);

    }


    public static class HabilidadesSeed
    {
        public static IReadOnlyList<Habilidade> Todas => new List<Habilidade>
    {
        // PROFISSIONAL
        new("Agricultura", GrupoHabilidade.Profissional, 1, AtributoTipo.Intelecto),
        new("Carpintaria", GrupoHabilidade.Profissional, 1, AtributoTipo.Agilidade),
        new("Engenharia", GrupoHabilidade.Profissional, 2, AtributoTipo.Intelecto),
        new("Náutica", GrupoHabilidade.Profissional, 1, AtributoTipo.Intelecto),
        new("Operação de Cerco", GrupoHabilidade.Profissional, 1, AtributoTipo.Percepcao),
        new("Trabalho em Metal", GrupoHabilidade.Profissional, 2, AtributoTipo.Fisico),
        new("Trabalhos Manuais", GrupoHabilidade.Profissional, 2, AtributoTipo.Agilidade),

        // MANOBRA
        new("Acrobacias", GrupoHabilidade.Manobra, 2, AtributoTipo.Agilidade, restrita:true),
        new("Aplicar Esforço", GrupoHabilidade.Manobra, 1, AtributoTipo.Forca),
        new("Corrida", GrupoHabilidade.Manobra, 1, AtributoTipo.Fisico),
        new("Escalar Superfícies", GrupoHabilidade.Manobra, 2, AtributoTipo.Forca),

        // CONHECIMENTO
        new("Escrita", GrupoHabilidade.Conhecimento, 2, AtributoTipo.Intelecto),
        new("Línguas", GrupoHabilidade.Conhecimento, 2, AtributoTipo.Intelecto, possuiArea:true),
        new("Medicina", GrupoHabilidade.Conhecimento, 1, AtributoTipo.Intelecto),
        new("Misticismo", GrupoHabilidade.Conhecimento, 1, AtributoTipo.Intelecto),
        new("Religião", GrupoHabilidade.Conhecimento, 1, AtributoTipo.Intelecto),

        // SUBTERFÚGIO
        new("Ações Furtivas", GrupoHabilidade.Subterfugio, 2, AtributoTipo.Agilidade),
        new("Destravar Fechaduras", GrupoHabilidade.Subterfugio, 1, AtributoTipo.Agilidade),
        new("Escapar", GrupoHabilidade.Subterfugio, 1, AtributoTipo.Agilidade),

        // INFLUÊNCIA
        new("Arte", GrupoHabilidade.Influencia, 1, AtributoTipo.Carisma, possuiArea:true),
        new("Etiqueta", GrupoHabilidade.Influencia, 1, AtributoTipo.Carisma),
        new("Negociação", GrupoHabilidade.Influencia, 1, AtributoTipo.Carisma),

        // GERAL
        new("Sobrevivência", GrupoHabilidade.Geral, 1, AtributoTipo.Percepcao),
        new("Usar os Sentidos", GrupoHabilidade.Geral, 2, AtributoTipo.Percepcao)
    };
    }

    public static class ProfissoesSeed
    {
        public static IReadOnlyList<ConfiguracaoProfissao> Todas => new[]
        {
        new ConfiguracaoProfissao
        {
            Profissao = Profissao.Guerreiro,
            PontosPorEstagio = 14,
            GrupoPenalizado = GrupoHabilidade.Influencia,
            HabilidadeAperfeicoada = "Aplicar Esforço"
        },
        new ConfiguracaoProfissao
        {
            Profissao = Profissao.Ladino,
            PontosPorEstagio = 22,
            GrupoPenalizado = null,
            HabilidadeAperfeicoada = "Ações Furtivas"
        },
        new ConfiguracaoProfissao
        {
            Profissao = Profissao.Mago,
            PontosPorEstagio = 12,
            GrupoPenalizado = GrupoHabilidade.Manobra,
            HabilidadeAperfeicoada = "Misticismo"
        }
    };
    }


    public class AdquirirHabilidadeUseCase
    {
        public void Executar(Personagem personagem, Habilidade habilidade, int niveis, ref int pontosDisponiveis)
        {
            var config = ProfissoesSeed.Todas
                .First(p => p.Profissao == personagem.Profissao);

            // Restrita
            if (habilidade.Restrita)
                throw new Exception("Habilidade restrita exige mestre.");

            var custoUnitario = HabilidadeService.CalcularCusto(habilidade, config);
            var custoTotal = custoUnitario * niveis;

            if (pontosDisponiveis < custoTotal)
                throw new Exception("Pontos insuficientes.");

            var existente = personagem.Habilidades
                .FirstOrDefault(h => h.Habilidade.Nome == habilidade.Nome);

            var novoNivel = (existente?.Nivel ?? 0) + niveis;

            // Limite por estágio
            HabilidadeService.ValidarNivel(novoNivel, personagem.Estagio);

            // Limite total de habilidades
            var limite = HabilidadeService.CalcularLimiteHabilidades(
                config.PontosPorEstagio,
                personagem.Estagio);

            if (personagem.Habilidades.Count >= limite && existente == null)
                throw new Exception("Limite máximo de habilidades atingido.");

            if (existente == null)
            {
                existente = new HabilidadePersonagem { Habilidade = habilidade };
                personagem.Habilidades.Add(existente);
            }

            existente.AumentarNivel(niveis);
            pontosDisponiveis -= custoTotal;
        }

        public int ObterTotalHabilidade(Personagem personagem, string nomeHabilidade)
        {
            var hab = personagem.Habilidades
                .First(h => h.Habilidade.Nome == nomeHabilidade);

            return HabilidadeService.CalcularTotal(
                hab,
                personagem.Atributos);
        }

        //var pontos = 14;

        //useCase.Executar(personagem, HabilidadesSeed.Todas.First(h => h.Nome == "Aplicar Esforço"),    1,    ref pontos);

        //var total = ObterTotalHabilidade(personagem, "Aplicar Esforço");


    }

}

