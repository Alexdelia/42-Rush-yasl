# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adelille <adelille@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/30 19:21:49 by adelille          #+#    #+#              #
#    Updated: 2022/04/09 14:30:06 by adelille         ###   ########.fr        #
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

define	diff
	@diff you expected
endef

define	test
	@$(YASL) $(SRC)$(1) > you
	@printf $(2) > expected
	@local res=$(diff) ; \
	if [[ $(res) -ne 0 ]]; then \
		printf "$(D)$(B)$(MAG)$(1)$(D)\n" ; \
		printf "\t$(D)$(B)$(GRE)expected:$(D)\n$(GRE)"; \
		cat expected; \
		printf "$(D)\n\t$(B)$(RED)you:$(D)\n$(RED)"; \
		cat you; \
		exit 1; \
	fi;
endef

# *************************************************************************** #
#	RULES	#

all:	test

man:
	man ressources/yasl.0

test:	ex00 ex01 ex02 ex03 fclean
	@printf "$(D)$(B)$(GRE)done$(D)\n"

ex00:
	$(call test,$(EX00),"Hello world\n")
	$(call test,$(EX00) hello,"Hello world\n")

ex01:
	$(call test,$(EX01),"")
	$(call test,$(EX01) Hello World 42 "Be Cool","Hello\nWorld\n42\nBe Cool\n")
	$(call test,$(EX01) "\n","\\\n\n")

ex02:
	$(call test,$(EX02),"")
	$(call test,$(EX02) 1,"")
	$(call test,$(EX02) 1 +,"")
	$(call test,$(EX02) 1 + 1 no,"")
	$(call test,$(EX02) 42 no 42,"no isn't supported\n")
	@$(YASL) $(SRC)$(EX02) 21 - 42 > you
	@echo "-21" > expected
	@diff you expected
	$(call test,$(EX02) 3 "+" 20,"23\n")
	$(call test,$(EX02) 3 "*" 5,"15\n")
	$(call test,$(EX02) 9 / 3,"3\n")
	$(call test,$(EX02) 42 % 10,"2\n")
	$(call test,$(EX02) 42 > 21,"1\n")
	$(call test,$(EX02) 42 < 21,"0\n")
	$(call test,$(EX02) 42 >= 42,"1\n")
	$(call test,$(EX02) 42 <= 21,"0\n")
	$(call test,$(EX02) 42 == 21,"0\n")
	$(call test,$(EX02) 42 == 42,"1\n")
	$(call test,$(EX02) 42 != 21,"1\n")
	$(call test,$(EX02) 42 != 42,"0\n")
	#@$(YASL) $(SRC)$(EX02) yes != 42 > tmp
	#@printf "" > expected
	#@diff tmp expected	
	#@$(YASL) $(SRC)$(EX02) 42n != 42 > tmp
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
	#@$(YASL) $(SRC)$(EX03) 2y yes no > tmp
	#@printf "use int > 0" > expected
	#@diff tmp expected

fclean:
	@$(RM) you
	@$(RM) expected

re:		fclean all

.PHONY: all man test fclean re ex00 ex01 ex02 ex03 ex04 ex05 ex06 display

# **************************************************************************** #
