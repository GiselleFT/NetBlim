-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(50) NOT NULL,
  `estado` TINYINT(1) NOT NULL,
  `fecha_registro` DATE NOT NULL,
  `contra` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Login` (
  `idLogin` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idLogin`),
  INDEX `fk_Login_Usuario_idx` (`Usuario_idUsuario` ASC),
  CONSTRAINT `fk_Login_Usuario`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `mydb`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Plan` (
  `idPlan` INT NOT NULL AUTO_INCREMENT,
  `max_dispo` INT NOT NULL,
  `costo` FLOAT NOT NULL,
  `metodo_pago` VARCHAR(45) NULL,
  PRIMARY KEY (`idPlan`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `Usuario_idUsuario` INT NOT NULL,
  `saldo` FLOAT NOT NULL,
  `Plan_idPlan` INT NOT NULL,
  INDEX `fk_Cliente_Plan1_idx` (`Plan_idPlan` ASC),
  PRIMARY KEY (`Usuario_idUsuario`),
  CONSTRAINT `fk_Cliente_Plan1`
    FOREIGN KEY (`Plan_idPlan`)
    REFERENCES `mydb`.`Plan` (`idPlan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `mydb`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Trabajador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Trabajador` (
  `Usuario_idUsuario` INT NOT NULL,
  `nombre` VARCHAR(80) NOT NULL,
  `tipo` INT NOT NULL,
  INDEX `fk_Trabajador_Usuario1_idx` (`Usuario_idUsuario` ASC),
  PRIMARY KEY (`Usuario_idUsuario`),
  CONSTRAINT `fk_Trabajador_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `mydb`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ganancia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ganancia` (
  `idGanancia` INT NOT NULL AUTO_INCREMENT,
  `monto` FLOAT NOT NULL,
  `fecha` DATE NOT NULL,
  `Plan_idPlan` INT NOT NULL,
  PRIMARY KEY (`idGanancia`),
  INDEX `fk_Ganancia_Plan1_idx` (`Plan_idPlan` ASC),
  CONSTRAINT `fk_Ganancia_Plan1`
    FOREIGN KEY (`Plan_idPlan`)
    REFERENCES `mydb`.`Plan` (`idPlan`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Trabajador_has_Ganancia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Trabajador_has_Ganancia` (
  `Trabajador_idTrabajador` INT NOT NULL,
  `Ganancia_idGanancia` INT NOT NULL,
  PRIMARY KEY (`Trabajador_idTrabajador`, `Ganancia_idGanancia`),
  INDEX `fk_Trabajador_has_Ganancia_Ganancia1_idx` (`Ganancia_idGanancia` ASC),
  CONSTRAINT `fk_Trabajador_has_Ganancia_Ganancia1`
    FOREIGN KEY (`Ganancia_idGanancia`)
    REFERENCES `mydb`.`Ganancia` (`idGanancia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Genero` (
  `idGenero` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idGenero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Clasificación`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Clasificación` (
  `idClasificación` INT NOT NULL AUTO_INCREMENT,
  `ctr_parental` BINARY(1) NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idClasificación`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Peli-serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Peli-serie` (
  `idPeli-serie` INT NOT NULL AUTO_INCREMENT,
  `Trabajador_idTrabajador` INT NOT NULL,
  `valoracion` FLOAT NOT NULL,
  `nombre` VARCHAR(60) NOT NULL,
  `fecha_registro` DATE NOT NULL,
  `estado` TINYINT(1) NOT NULL,
  `anio` VARCHAR(4) NOT NULL,
  `url_imagen` VARCHAR(120) NOT NULL,
  `Descripcion` VARCHAR(500) NOT NULL,
  `Genero_idGenero` INT NOT NULL,
  `Clasificación_idClasificación` INT NOT NULL,
  PRIMARY KEY (`idPeli-serie`),
  INDEX `fk_Peli-serie_Genero1_idx` (`Genero_idGenero` ASC),
  INDEX `fk_Peli-serie_Clasificación1_idx` (`Clasificación_idClasificación` ASC),
  CONSTRAINT `fk_Peli-serie_Genero1`
    FOREIGN KEY (`Genero_idGenero`)
    REFERENCES `mydb`.`Genero` (`idGenero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Peli-serie_Clasificación1`
    FOREIGN KEY (`Clasificación_idClasificación`)
    REFERENCES `mydb`.`Clasificación` (`idClasificación`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Dire_actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Dire_actor` (
  `idDire_actor` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `tipo` INT NOT NULL,
  PRIMARY KEY (`idDire_actor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Dire_actor_has_Peli-serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Dire_actor_has_Peli-serie` (
  `Dire_actor_idDire_actor` INT NOT NULL,
  `Peli-serie_idPeli-serie` INT NOT NULL,
  PRIMARY KEY (`Dire_actor_idDire_actor`, `Peli-serie_idPeli-serie`),
  INDEX `fk_Dire_actor_has_Peli-serie_Peli-serie1_idx` (`Peli-serie_idPeli-serie` ASC),
  INDEX `fk_Dire_actor_has_Peli-serie_Dire_actor1_idx` (`Dire_actor_idDire_actor` ASC),
  CONSTRAINT `fk_Dire_actor_has_Peli-serie_Dire_actor1`
    FOREIGN KEY (`Dire_actor_idDire_actor`)
    REFERENCES `mydb`.`Dire_actor` (`idDire_actor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dire_actor_has_Peli-serie_Peli-serie1`
    FOREIGN KEY (`Peli-serie_idPeli-serie`)
    REFERENCES `mydb`.`Peli-serie` (`idPeli-serie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Perfil` (
  `idPerfil` INT NOT NULL AUTO_INCREMENT,
  `url_imagen` VARCHAR(120) NULL,
  `nombre` VARCHAR(80) NOT NULL,
  `ctr_parental` TINYINT(1) NOT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPerfil`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Peli-serie_has_Perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Peli-serie_has_Perfil` (
  `Peli-serie_idPeli-serie` INT NOT NULL,
  `Perfil_idPerfil` INT NOT NULL,
  PRIMARY KEY (`Peli-serie_idPeli-serie`, `Perfil_idPerfil`),
  INDEX `fk_Peli-serie_has_Perfil_Perfil1_idx` (`Perfil_idPerfil` ASC),
  INDEX `fk_Peli-serie_has_Perfil_Peli-serie1_idx` (`Peli-serie_idPeli-serie` ASC),
  CONSTRAINT `fk_Peli-serie_has_Perfil_Peli-serie1`
    FOREIGN KEY (`Peli-serie_idPeli-serie`)
    REFERENCES `mydb`.`Peli-serie` (`idPeli-serie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Peli-serie_has_Perfil_Perfil1`
    FOREIGN KEY (`Perfil_idPerfil`)
    REFERENCES `mydb`.`Perfil` (`idPerfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Actividad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Actividad` (
  `idActividad` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `Perfil_idPerfil` INT NOT NULL,
  `Peli-serie_idPeli-serie` INT NOT NULL,
  PRIMARY KEY (`idActividad`),
  INDEX `fk_Actividad_Perfil1_idx` (`Perfil_idPerfil` ASC),
  INDEX `fk_Actividad_Peli-serie1_idx` (`Peli-serie_idPeli-serie` ASC),
  CONSTRAINT `fk_Actividad_Perfil1`
    FOREIGN KEY (`Perfil_idPerfil`)
    REFERENCES `mydb`.`Perfil` (`idPerfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Actividad_Peli-serie1`
    FOREIGN KEY (`Peli-serie_idPeli-serie`)
    REFERENCES `mydb`.`Peli-serie` (`idPeli-serie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Idioma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Idioma` (
  `idIdioma` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idIdioma`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Idioma_has_Peli-serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Idioma_has_Peli-serie` (
  `Idioma_idIdioma` INT NOT NULL,
  `Peli-serie_idPeli-serie` INT NOT NULL,
  PRIMARY KEY (`Idioma_idIdioma`, `Peli-serie_idPeli-serie`),
  INDEX `fk_Idioma_has_Peli-serie_Peli-serie1_idx` (`Peli-serie_idPeli-serie` ASC),
  INDEX `fk_Idioma_has_Peli-serie_Idioma1_idx` (`Idioma_idIdioma` ASC),
  CONSTRAINT `fk_Idioma_has_Peli-serie_Idioma1`
    FOREIGN KEY (`Idioma_idIdioma`)
    REFERENCES `mydb`.`Idioma` (`idIdioma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Idioma_has_Peli-serie_Peli-serie1`
    FOREIGN KEY (`Peli-serie_idPeli-serie`)
    REFERENCES `mydb`.`Peli-serie` (`idPeli-serie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Subtitulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Subtitulo` (
  `idSubtitulo` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSubtitulo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Subtitulo_has_Peli-serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Subtitulo_has_Peli-serie` (
  `Subtitulo_idSubtitulo` INT NOT NULL,
  `Peli-serie_idPeli-serie` INT NOT NULL,
  PRIMARY KEY (`Subtitulo_idSubtitulo`, `Peli-serie_idPeli-serie`),
  INDEX `fk_Subtitulo_has_Peli-serie_Peli-serie1_idx` (`Peli-serie_idPeli-serie` ASC),
  INDEX `fk_Subtitulo_has_Peli-serie_Subtitulo1_idx` (`Subtitulo_idSubtitulo` ASC),
  CONSTRAINT `fk_Subtitulo_has_Peli-serie_Subtitulo1`
    FOREIGN KEY (`Subtitulo_idSubtitulo`)
    REFERENCES `mydb`.`Subtitulo` (`idSubtitulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Subtitulo_has_Peli-serie_Peli-serie1`
    FOREIGN KEY (`Peli-serie_idPeli-serie`)
    REFERENCES `mydb`.`Peli-serie` (`idPeli-serie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pelicula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pelicula` (
  `Peli-serie_idPeli-serie` INT NOT NULL,
  `duracion` INT NOT NULL,
  PRIMARY KEY (`Peli-serie_idPeli-serie`),
  CONSTRAINT `fk_Pelicula_Peli-serie1`
    FOREIGN KEY (`Peli-serie_idPeli-serie`)
    REFERENCES `mydb`.`Peli-serie` (`idPeli-serie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Serie` (
  `Peli-serie_idPeli-serie` INT NOT NULL,
  PRIMARY KEY (`Peli-serie_idPeli-serie`),
  CONSTRAINT `fk_Serie_Peli-serie1`
    FOREIGN KEY (`Peli-serie_idPeli-serie`)
    REFERENCES `mydb`.`Peli-serie` (`idPeli-serie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Temporada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Temporada` (
  `idTemporada` INT NOT NULL,
  `numero` INT NOT NULL,
  `Serie_Peli-serie_idPeli-serie` INT NOT NULL,
  PRIMARY KEY (`idTemporada`),
  INDEX `fk_Temporada_Serie1_idx` (`Serie_Peli-serie_idPeli-serie` ASC),
  CONSTRAINT `fk_Temporada_Serie1`
    FOREIGN KEY (`Serie_Peli-serie_idPeli-serie`)
    REFERENCES `mydb`.`Serie` (`Peli-serie_idPeli-serie`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Capitulo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Capitulo` (
  `idCapitulo` INT NOT NULL,
  `duracion` INT NOT NULL,
  `Capitulo_idCapitulo` INT NOT NULL,
  `sinopsis` VARCHAR(500) NOT NULL,
  `Temporada_idTemporada` INT NOT NULL,
  PRIMARY KEY (`idCapitulo`, `Capitulo_idCapitulo`),
  INDEX `fk_Capitulo_Capitulo1_idx` (`Capitulo_idCapitulo` ASC),
  INDEX `fk_Capitulo_Temporada1_idx` (`Temporada_idTemporada` ASC),
  CONSTRAINT `fk_Capitulo_Capitulo1`
    FOREIGN KEY (`Capitulo_idCapitulo`)
    REFERENCES `mydb`.`Capitulo` (`idCapitulo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Capitulo_Temporada1`
    FOREIGN KEY (`Temporada_idTemporada`)
    REFERENCES `mydb`.`Temporada` (`idTemporada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
