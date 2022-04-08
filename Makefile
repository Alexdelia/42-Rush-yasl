# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: adelille <adelille@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/30 19:21:49 by adelille          #+#    #+#              #
#    Updated: 2022/04/08 22:57:09 by adelille         ###   ########.fr        #
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
EX00 =		ex00/yasl_hw
EX01 =		ex01/yasl_aff_param

# *************************************************************************** #

# *************************************************************************** #
#	RULES	#

all:	test

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

fclean:
	@$(RM) tmp
	@$(RM) expected

re:		fclean all

.PHONY: all test ex00 ex01 ex02 ex03 ex04 ex05 ex06 display

# **************************************************************************** #
