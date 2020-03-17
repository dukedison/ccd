CREATE SCHEMA IF NOT EXISTS `ccd` DEFAULT CHARACTER SET utf8 ;
USE `ccd` ;

-- -----------------------------------------------------
-- Table `ccd`.`table1`
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Table `ccd`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ccd`.`cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono` INT(15) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ccd`.`categoriaRestaurante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ccd`.`categoriaRestaurante` (
  `idCategoriaRestaurante` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idCategoriaRestaurante`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ccd`.`restaurante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ccd`.`restaurante` (
  `idRestaurante` INT NOT NULL AUTO_INCREMENT,
  `idCategoriaRestaurante` INT NOT NULL,
  `nit` INT(12) NULL,
  `nombre` VARCHAR(40) NULL,
  `direccion` VARCHAR(50) NULL,
  PRIMARY KEY (`idRestaurante`),
  INDEX `FK_categoriaRestaurante_idx` (`idCategoriaRestaurante` ASC),
  CONSTRAINT `FK_categoriaRestaurante`
    FOREIGN KEY (`idCategoriaRestaurante`)
    REFERENCES `ccd`.`categoriaRestaurante` (`idCategoriaRestaurante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ccd`.`categoriaProducto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ccd`.`categoriaProducto` (
  `idCategoriaProducto` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idCategoriaProducto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ccd`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ccd`.`producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `idCategoriaProducto` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(50) NULL,
  `precio` DECIMAL(10) NULL,
  `foto` VARCHAR(200) NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `FK_productoCategoria_idx` (`idCategoriaProducto` ASC),
  CONSTRAINT `FK_productoCategoria`
    FOREIGN KEY (`idCategoriaProducto`)
    REFERENCES `ccd`.`categoriaProducto` (`idCategoriaProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ccd`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ccd`.`menu` (
  `idMenu` INT NOT NULL AUTO_INCREMENT,
  `idProducto` INT NOT NULL,
  `idRestaurante` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `descripcion` LONGTEXT NULL,
  PRIMARY KEY (`idMenu`),
  INDEX `FK_idMenuRestaurante_idx` (`idRestaurante` ASC),
  INDEX `FK_MenuProducto_idx` (`idProducto` ASC),
  CONSTRAINT `FK_MenuRestaurante`
    FOREIGN KEY (`idRestaurante`)
    REFERENCES `ccd`.`restaurante` (`idRestaurante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_MenuProducto`
    FOREIGN KEY (`idProducto`)
    REFERENCES `ccd`.`producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ccd`.`categoriaIngrediente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ccd`.`categoriaIngrediente` (
  `idCategoriaIngrediente` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(50) NULL,
  PRIMARY KEY (`idCategoriaIngrediente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ccd`.`ingrediente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ccd`.`ingrediente` (
  `idIngrediente` INT NOT NULL AUTO_INCREMENT,
  `idCategoriaIngrediente` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `estado` TINYINT NOT NULL,
  INDEX `FK_ingredienteCategoria_idx` (`idCategoriaIngrediente` ASC),
  PRIMARY KEY (`idIngrediente`),
  CONSTRAINT `FK_ingredienteCategoria`
    FOREIGN KEY (`idCategoriaIngrediente`)
    REFERENCES `ccd`.`categoriaIngrediente` (`idCategoriaIngrediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ccd`.`productoIngrediente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ccd`.`productoIngrediente` (
  `idProducto` INT NOT NULL ,
  `idIngrediente` INT NOT NULL,
  INDEX `FK_productoIngrediente_idx` (`idIngrediente` ASC),
  INDEX `FK_productoIngrediente1_idx` (`idProducto` ASC),
  CONSTRAINT `FK_productoIngrediente`
    FOREIGN KEY (`idIngrediente`)
    REFERENCES `ccd`.`ingrediente` (`idIngrediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_productoIngrediente1`
    FOREIGN KEY (`idProducto`)
    REFERENCES `ccd`.`producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ccd`.`pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ccd`.`pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `idCliente` INT NOT NULL,
  `idRestaurante` INT NOT NULL,
  `comentario` VARCHAR(100) NULL,
  `precioTotal` DECIMAL(12) NULL,
  PRIMARY KEY (`idPedido`),
  INDEX `FK_pedidoCliente_idx` (`idCliente` ASC),
  INDEX `FK_pedidoRestaurante_idx` (`idRestaurante` ASC),
  CONSTRAINT `FK_pedidoCliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `ccd`.`cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_pedidoRestaurante`
    FOREIGN KEY (`idRestaurante`)
    REFERENCES `ccd`.`restaurante` (`idRestaurante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ccd`.`detallePedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ccd`.`detallePedido` (
  `idDetallePedido` INT NOT NULL AUTO_INCREMENT,
  `idPedido` INT NOT NULL,
  `idProducto` INT NOT NULL,
  `precioUnitario` DECIMAL(15) NULL,
  PRIMARY KEY (`idDetallePedido`),
  INDEX `FK_detallePedido_idx` (`idPedido` ASC),
  INDEX `FK_detalleProducto_idx` (`idProducto` ASC),
  CONSTRAINT `FK_detallePedido`
    FOREIGN KEY (`idPedido`)
    REFERENCES `ccd`.`pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_detalleProducto`
    FOREIGN KEY (`idProducto`)
    REFERENCES `ccd`.`producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
