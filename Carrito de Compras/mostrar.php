<?php
include 'global/config.php'; 
include 'carrito.php'; 
include 'templates/cabecera.php';
?>
<br>
<h3>Lista del Carrito</h3>
<?php if(isset($_SESSION['CARRITO']) && !empty($_SESSION['CARRITO'])) { ?>
    <table class="table table-light table-bordered">
        <thead>
            <tr>
                <th width="40%">Descripción</th>
                <th width="15%" class="text-center">Cantidad</th>
                <th width="20%" class="text-center">Precio</th>
                <th width="20%" class="text-center">Total</th>
                <th width="5%">Eliminar</th>
            </tr>
        </thead>
        <tbody>
            <?php 
            $total = 0;
            foreach($_SESSION['CARRITO'] as $indice => $producto) {
                ?>
                <tr>
                    <td width="40%"><?php echo $producto['NOMBRE']?></td>
                    <td width="15%" class="text-center"><?php echo $producto['CANTIDAD']?></td>
                    <td width="20%" class="text-center"><?php echo $producto['PRECIO']?></td>
                    <td width="20%" class="text-center"><?php echo number_format($producto['PRECIO'] * $producto['CANTIDAD'], 2);?></td>
                    <td width="5%">
                        <form action="" method="POST">
                            <input type="hidden" name="id" id="id" value="<?php echo openssl_encrypt($producto['ID'], COD, KEY);?>">
                            <button class="btn btn-danger" type="submit" name="btnAccion" value="Eliminar">Eliminar</button>
                        </form>    
                    </td>
                </tr>
                <?php 
                $total += ($producto['PRECIO'] * $producto['CANTIDAD']);
            } ?>
            <tr>
                <td colspan="3" align="right"><h3>Total</h3></td>
                <td align="right"><h3>$<?php echo number_format($total, 2);?></h3></td>
                <td></td>
            </tr> 
            <tr>
                <td colspan="5">
                    <button class="btn btn-info btn-lg btn-block" type="button" data-toggle="modal" data-target="#facturaModal">Imprimir Factura</button>
                </td>
            </tr>          
        </tbody>
    </table>
<?php } else { ?>
    <div class="alert alert-success">
        No hay productos en el carrito
    </div>
<?php } ?>  
<?php include 'templates/pie.php';?>

<!-- Modal -->
<div class="modal fade" id="facturaModal" tabindex="-1" role="dialog" aria-labelledby="facturaModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="facturaModalLabel">Factura</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- Aquí se insertará la factura -->
        <div id="facturaContent">
          <!-- Factura content goes here -->
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
        <button type="button" class="btn btn-primary" onclick="imprimirFactura()">Imprimir</button>
      </div>
    </div>
  </div>
</div>

<script>
function imprimirFactura() {
    var contenido = document.getElementById('facturaContent').innerHTML;
    var ventana = window.open('', '_blank');
    ventana.document.write('<html><head><title>Factura</title>');
    ventana.document.write('<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">');
    ventana.document.write('<style>');
    ventana.document.write('.factura { padding: 20px; }');
    ventana.document.write('.factura h3 { text-align: center; margin-bottom: 20px; }');
    ventana.document.write('.factura table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }');
    ventana.document.write('.factura th, .factura td { border: 1px solid #ddd; padding: 8px; text-align: center; }');
    ventana.document.write('.factura th { background-color: #f2f2f2; }');
    ventana.document.write('.factura .total { font-weight: bold; }');
    ventana.document.write('</style>');
    ventana.document.write('</head><body class="factura">');
    ventana.document.write(contenido);
    ventana.document.write('</body></html>');
    ventana.document.close();
    ventana.print();
}

$(document).ready(function() {
    $('#facturaModal').on('show.bs.modal', function (event) {
        var modal = $(this);
        var facturaContent = '';

        facturaContent += '<div class="factura">';
        facturaContent += '<h3>Factura</h3>';
        facturaContent += '<table class="table table-bordered">';
        facturaContent += '<thead><tr><th>Descripción</th><th class="text-center">Cantidad</th><th class="text-center">Precio</th><th class="text-center">Total</th></tr></thead>';
        facturaContent += '<tbody>';
        <?php foreach($_SESSION['CARRITO'] as $indice => $producto) { ?>
            facturaContent += '<tr>';
            facturaContent += '<td><?php echo $producto['NOMBRE'] ?></td>';
            facturaContent += '<td class="text-center"><?php echo $producto['CANTIDAD'] ?></td>';
            facturaContent += '<td class="text-center"><?php echo $producto['PRECIO'] ?></td>';
            facturaContent += '<td class="text-center"><?php echo number_format($producto['PRECIO'] * $producto['CANTIDAD'], 2) ?></td>';
            facturaContent += '</tr>';
        <?php } ?>
        facturaContent += '<tr><td colspan="3" align="right" class="total">Total</td><td align="right" class="total">$<?php echo number_format($total, 2) ?></td></tr>';
        facturaContent += '</tbody></table>';
        facturaContent += '</div>';

        modal.find('.modal-body #facturaContent').html(facturaContent);
    });
});
</script>
