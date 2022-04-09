# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adelille <adelille@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/30 19:21:49 by adelille          #+#    #+#              #
#    Updated: 2022/04/09 13:39:30 by adelille         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

ifeq ($(shell uname), Linux)
	YASL =	./ressources/yasl_linux
else
	YASL =	./ressources/yasl_macos
endif

RM = 	rm -rf

# **************************************************************************** #
#	MAKEFILE	#

#MAKEFLAGS += --silent

SHELL := bash

B =		$(shell tput bold)
BLA =	$(shell tput setaf 0)
RED =	$(shell tput setaf 1)
GRE =	$(shell tput setaf 2)
YEL =	$(shell tput setaf 3)
BLU =	$(shell tput setaf 4)
MAG =	$(shell tput setaf 5)
CYA =	$(shell tput setaf 6)
WHI =	$(shell tput setaf 7)
D =		$(shell tput sgr0)
BEL =	$(shell tput bel)
CLR =	$(shell tput el 1)

# **************************************************************************** #
#	SRCS	#

SRC =	./src/
EX00 =	ex00/yasl_hw
EX01 =	ex01/yasl_aff_param
EX02 =	ex02/yasl_do
EX03 =	ex03/yasl_repeat

# *************************************************************************** #

# *************************************************************************** #
#	RULES	#

all:	test

man:
	man ressources/yasl.0

test:	ex00 ex01 fclean
	@printf "$(D)$(B)$(GRE)done$(D)\n"

ex00:
	@$(YASL) $(SRC)$(EX00) > tmp
	@printf "Hello world\n" > expected
	@diff tmp expected

ex01:
	@$(YASL) $(SRC)$(EX01) > tmp
	@printf "" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX01) Hello World 42 "Be Cool" > tmp
	@printf "Hello\nWorld\n42\nBe Cool\n" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX01) "\n" > tmp
	@printf "\\\n\n" > expected
	@diff tmp expected

ex02:
	@$(YASL) $(SRC)$(EX02) > tmp
	@printf "" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX02) 1 > tmp
	@printf "" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX02) 1 + > tmp
	@printf "" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX02) 1 + 1 no > tmp
	@printf "" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX02) 42 no 42 > tmp
	@printf "no isn't supported" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX02) 21 - 42 > tmp
	@printf "-21" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX02) 3 "+" 20 > tmp
	@printf "23" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX02) 3 * 5 > tmp
	@printf "15" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX02) 3 / 9 > tmp
	@printf "3" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX02) 42 % 10 > tmp
	@printf "2" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX02) 42 > 21 > tmp
	@printf "1" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX02) 42 < 21 > tmp
	@printf "0" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX02) 42 >= 42 > tmp
	@printf "1" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX02) 42 <= 21 > tmp
	@printf "0" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX02) 42 == 21 > tmp
	@printf "0" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX02) 42 == 42 > tmp
	@printf "1" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX02) 42 != 21 > tmp
	@printf "1" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX02) 42 != 42 > tmp
	@printf "0" > expected
	@diff tmp expected
	#@$(YASL) $(SRC)$(EX02) yes != 42 > tmp
	#@printf "" > expected
	#@diff tmp expected	

ex03:
	@$(YASL) $(SRC)$(EX03) > tmp
	@printf "" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX03) 1 > tmp
	@printf "" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX03) 1 yes > tmp
	@printf "yes\n" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX03) 2 yes > tmp
	@printf "yesyes\n" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX03) 2 yes no > tmp
	@printf "yesyes\nnonono\n" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX03) 4 Bonjour "how are you?" > tmp
	@printf "BonjourBonjourBonjourBonjour\nhow are you?how are you?how are you?how are you?how are you?\n" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX03) 1 "************" "******" "****" "---" > tmp
	@printf "************\n************\n************\n------------\n" > expected
	@diff tmp expected
	@$(YASL) $(SRC)$(EX03) no yes no > tmp
	@printf "use int > 0" > expected
	@diff tmp expected

fclean:
	@$(RM) tmp
	@$(RM) expected

re:		fclean all

.PHONY: all man test fclean re ex00 ex01 ex02 ex03 ex04 ex05 ex06 display

# **************************************************************************** #
