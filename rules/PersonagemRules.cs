using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TagPerson.Domain.ValueObjects
{
    public class Atributos
    {
        public int Agilidade { get; init; }
        public int Aura { get; init; }
        public int Carisma { get; init; }
        public int Fisico { get; init; }
        public int Forca { get; init; }
        public int Intelecto { get; init; }
        public int Percepcao { get; init; }
    }

    public class Personagem
    {
        public int Estagio { get; set; }
        public Raca Raca { get; init; }
        public Profissao Profissao { get; init; }
        public Atributos? Atributos { get; init; }

        public int ResistênciaFisica { get; set; }
        public int ResistênciaMagia { get; set; }
        public int VelocidadeBase { get; set; }
        public int EnergiaFisica { get; set; }
        public int EnergiaHeroica { get; set; }
        public int Karma { get; set; }

        public int Estagio { get; private set; } = 1;
        public Experiencia XP { get; } = new();

    }

    public enum Raca
    {
        Humano,
        Anão,
        ElfoDourado,
        ElfoFlorestal,
        MeioElfo,
        Pequenino
    }

    public enum Profissao
    {
        Guerreiro,
        Ladino,
        Mago,
        Sacerdote,
        Rastreador,
        Bardo
    }

    public static class ResistenciaService
    {
        public static int CalcularResistenciaFisica(int estagio, int fisico) => estagio + fisico;

        public static int CalcularResistenciaMagia(int estagio, int aura) => estagio + aura;
    }

    public static class MovimentoService
    {
        public static int CalcularVelocidadeBase(Raca raca, int fisico)
        {
            var baseRaca = raca switch
            {
                Raca.Anão => 16,
                Raca.ElfoDourado => 18,
                Raca.ElfoFlorestal => 18,
                Raca.Humano => 20,
                Raca.MeioElfo => 17,
                Raca.Pequenino => 14,
                _ => throw new ArgumentOutOfRangeException()
            };

            return baseRaca + fisico;
        }
    }

    public static class EnergiaService
    {
        public static int CalcularEnergiaFisica(Raca raca, int forca, int fisico, int absorcaoEquipamentos = 0)
        {
            var baseEf = raca switch
            {
                Raca.Anão => 15,
                Raca.ElfoDourado => 13,
                Raca.ElfoFlorestal => 14,
                Raca.Humano => 17,
                Raca.MeioElfo => 15,
                Raca.Pequenino => 11,
                _ => throw new ArgumentOutOfRangeException()
            };

            return baseEf + forca + fisico + absorcaoEquipamentos;
        }

        public static int CalcularEnergiaHeroica(Profissao profissao, int fisico)
        {
            var baseEh = profissao switch
            {
                Profissao.Guerreiro => 18,
                Profissao.Ladino => 12,
                Profissao.Mago => 6,
                Profissao.Rastreador => 15,
                Profissao.Sacerdote => 12,
                Profissao.Bardo => 9,
                _ => throw new ArgumentOutOfRangeException()
            };

            return baseEh + fisico;
        }

        public static int CalcularKarma(int aura, int estagio)
        {
            if (aura <= 0)
                return 0;

            return (aura + 1) * (estagio + 1);
        }
    }

    public class CriarPersonagemService
    {
        public Personagem Criar(Personagem personagem)
        {
            personagem.ResistênciaFisica =
                ResistenciaService.CalcularResistenciaFisica(
                    personagem.Estagio,
                    personagem.Atributos.Fisico);

            personagem.ResistênciaMagia =
                ResistenciaService.CalcularResistenciaMagia(
                    personagem.Estagio,
                    personagem.Atributos.Aura);

            personagem.VelocidadeBase =
                MovimentoService.CalcularVelocidadeBase(
                    personagem.Raca,
                    personagem.Atributos.Fisico);

            personagem.EnergiaFisica =
                EnergiaService.CalcularEnergiaFisica(
                    personagem.Raca,
                    personagem.Atributos.Forca,
                    personagem.Atributos.Fisico);

            personagem.EnergiaHeroica =
                EnergiaService.CalcularEnergiaHeroica(
                    personagem.Profissao,
                    personagem.Atributos.Fisico);

            personagem.Karma =
                EnergiaService.CalcularKarma(
                    personagem.Atributos.Aura,
                    personagem.Estagio);

            return personagem;
        }
    }

    public static class ExperienciaTabela
    {
        public static int XPParaProximoNivel(int estagioAtual) => estagioAtual * 1000;
    }

    public class Experiencia
    {
        public int Total { get; private set; }

        public void Adicionar(int xp)
        {
            if (xp <= 0)
                return;

            Total += xp;
        }
    }

    public static class ProgressaoService
    {
        public static bool PodeSubirNivel(Personagem personagem)
        {
            var necessario = ExperienciaTabela
                .XPParaProximoNivel(personagem.Estagio);

            return personagem.XP.Total >= necessario;
        }
    }

    public class SubirNivelService
    {
        public void Executar(Personagem personagem)
        {
            if (!ProgressaoService.PodeSubirNivel(personagem))
                return;

            personagem.XP.Adicionar(
                -ExperienciaTabela.XPParaProximoNivel(personagem.Estagio));

            personagem.Estagio++;

            AplicarGanhos(personagem);
        }

        private void AplicarGanhos(Personagem personagem)
        {
            var pontosHabilidade = ProfissoesSeed.Todas.First(p => p.Profissao == personagem.Profissao).PontosPorEstagio;
            personagem.PontosHabilidade += pontosHabilidade;
        }
        public static int CalcularXPCombate(int estagioInimigo) => estagioInimigo * 100;


    }

    public class ConcederExperienciaUseCase
    {
        private readonly SubirNivelService _subirNivel = new();

        public void Executar(Personagem personagem, int xpGanha)
        {
            personagem.XP.Adicionar(xpGanha);

            while (ProgressaoService.PodeSubirNivel(personagem))
            {
                _subirNivel.Executar(personagem);
            }
        }
    }

    // var pontosCombate = CombateProfissaoSeed.PontosPorEstagio(personagem.Profissao);
    // personagem.PontosCombate += pontosCombate;
    // personagem.EnergiaFisicaMax += personagem.Atributos.Fisico;
    // personagem.EnergiaHeroicaMax += personagem.Atributos.Fisico / 2;
    //ConcederExperienciaUseCase.Executar(personagem, 1200);
    // personagem sobe do estágio 1 para 2

}
