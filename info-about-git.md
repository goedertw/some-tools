# Werken met Git in een team

Als je met Git werkt in een team, bestaat de kans dat je conflicten introduceert wanneer verschillende teamleden hetzelfde bestand bewerken en een nieuwe versie opladen naar Github. Enkele tips om dit te vermijden en de belangrijkste commando's die je zal nodig hebben. De meesten werken wellicht met een grafische tool als SourceTree of Github Desktop, maar de command-line tool is eigenlijk heel goed en geeft ook telkens aan wat de volgende stap is en hoe je een stap kan ongedaan maken. De foutboodschappen (als je ze goed leest) geven ook meestal een goed idee van wat er is misgegaan en hoe je dit kan oplossen.

Probeer Git zo snel mogelijk onder de knie te krijgen en te begrijpen, je zal dit toch voortdurend nodig hebben... Commit regelmatig (meerdere keren per werksessie). Geef een goede beschrijving (je teamleden en je toekomstige zelf zullen je dankbaar zijn).

Werken met branches is in principe niet nodig en wordt hier niet besproken.

## Configuratie Git

Bij installatie van [Git voor Windows](https://git-scm.com/download/), zorg er voor dat ook Git Bash geïnstalleerd wordt. Om synchronisatie met Github te vereenvoudigen, is het best om een [SSH-sleutelpaar](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) aan te maken. Wanneer gevraagd wordt om een "passphrase" in te voeren, mag je die leeg laten. Volg de instructies van Github om je [SSH-sleutel te registreren](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/).

Start een console en voer volgende stappen uit voor de basisconfiguratie van Git. Gebruik het emailadres dat gekoppeld is aan je Github-account.

```
$ git config --global user.name "<GITHUB-USERNAAM>"
$ git config --global user.email "<VOORNAAM.NAAM>@hogent.be"
$ git config --global push.default simple
```

## Opstart project

Eén teamlid maakt een repository aan op Github.
De andere leden maken lokaal een kopie (kloon) van die Github-repository.

1. Ga naar de repository op Github, klik rechts op de groene knop "Clone or Download". zorg dat "SSH" geselecteerd is. Kopieer de URL (begint met `git@github.com:...`)
2. Open Git Bash in een directory waar je de lokale repository wil bijhouden
3. `git clone git@github.com:<GITHUB-USERNAAM>/<REPO-NAAM>.git`

Je kan de naam van de lokale directory wijzigen in wat je zelf wil.

## Workflow

1. Voor je begint wijzigingen aan te brengen, haal eerst eventuele wijzigingen van Github binnen:

    ```
    $ git pull
    ```

2. Maak je eigen wijzigingen en commit ze lokaal:

    ```
    $ git add .
    $ git commit -m "Beschrijving van de wijziging"
    ```

3. Stuur je wijzigingen naar Github:

    ```
    $ git push
    ```

4. Als de `git push` uit stap 3 lukt, dan is alles in orde. Als de `git push` faalt met de foutmelding `[rejected]`, dan zul je eerst de nieuwe wijzigingen van Github halen en ze ***mergen*** met jouw lokale wijzigingen:

    ```
    $ git pull --no-commit
    ```

5. Bekijk het resultaat van deze merge:

    ```
    $ git diff HEAD
    ```

6. Los eventuele conflicten op door de betreffende bestanden aan te passen. Herhaal de `git diff HEAD` tot je tevreden bent. Daarna commit je het resultaat van de merge:

	```
	$ git add .
	$ git commit -m "Merging from master"
	```

7. Ga terug naar stap 3.

Voer de `git pull` (stap 1) en `git push` (stap 3) zo vaak mogelijk uit.
Hierdoor zullen het aantal "rejected" pushes, en dus ook het aantal merges en conflicten, beperkt blijven.
Goede afspraken maken en de taken goed verdelen, helpt uiteraard ook om merge-conflicten te voorkomen.

Er zijn ook enkele commando's die je extra informatie en inzicht geven, zonder de toestand van de repositorie of de bestanden te wijzigen. Probeer ze uit:

```
$ git status
$ git diff
$ git log
$ git log --graph --pretty="%C(red)%h %C(blue)%ai %C(green)%aN %C(reset)%s%C(red)%d"
$ git whatchanged
$ git whatchanged --graph --pretty="%C(red)%h %C(blue)%ai %C(green)%aN %C(reset)%s%C(red)%d"
$ git blame FILENAME
```

Met `git help` krijg je meer info over de git-commando's. Bijvoorbeeld:

```
$ git help commit
$ git help diff
$ git help log
```

### Aknowledgment

Deze tekst is gebaseerd op een document van Bert Van Vreckem. Het werd verder aangepast door Wim Goedertier. 
