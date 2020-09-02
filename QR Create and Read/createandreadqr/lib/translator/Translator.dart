import 'dart:ui';

final _sysLng = window.locale.languageCode;

//Nome
getTranslators() {
  switch (_sysLng) {
    //Português
    case 'pt':
      return ({
        //Menu
        'readQR': "Leia um QR Code",
        'createQR': "Crie seu próprio QR Code",
        //CreatorView
        'qrData': 'Conteúdo do código QR',
        'createQRAppBar': 'Crie o seu código QR',
        'background': 'Fundo  ',
        'foreground': 'Linhas  ',
        'select': 'Selecionar',
        'colorsWarning': 'Selecione cores fortes e contrastantes',
        'saveGallery': 'Salvar na galeria',
        'success': 'Sucesso',
        'saveSuccess': 'QR Code foi enviado para a galeria',
        'error': 'Erro',
        'errorMsg': 'Permissão negada',
        //ResultQrReaderView
        'resultPage': 'Resultado do QR Code',
        'clickToLaunch': 'Clique para iniciar no navegador',
        'clickCopy': 'Clique para copiar',
        'copied': 'Copiado',
        'copiedMsg': 'Os dados foram copiados para a área de transferência',
      });
      break;

    //Spanish
    case 'es':
      return ({
        //Menu
        'readQR': "Leer un código QR",
        'createQR': "Crea tu propio código QR",
        //CreatorView
        'qrData': 'Contenido del código QR',
        'createQRAppBar': 'Crea tu código QR',
        'background': 'Fondo  ',
        'foreground': 'Líneas  ',
        'select': 'Seleccione',
        'colorsWarning': 'Seleccione colores fuertes y contrastantes',
        'saveGallery': 'Guardar en la galería',
        'success': 'Éxito',
        'saveSuccess': 'Se envió el código QR a la galería',
        'error': 'Error',
        'errorMsg': 'Permiso denegado',
        //ResultQrReaderView
        'resultPage': 'Resultado del código QR',
        'clickToLaunch': 'Haga clic para iniciar en el navegador',
        'clickCopy': 'Haga clic para copiar',
        'copied': 'Copiado',
        'copiedMsg': 'Los datos se han copiado al portapapeles',
      });
      break;

    //English
    default:
      return ({
        //Menu
        'readQR': "Read a QR Code",
        'createQR': "Create your own QR Code",
        //CreatorView
        'qrData': 'QR Code content',
        'createQRAppBar': 'Create your QR Code',
        'background': 'Background  ',
        'foreground': 'Foreground  ',
        'select': 'Select',
        'colorsWarning': 'Select strong and contrasting colors',
        'saveGallery': 'Save to gallery',
        'success': 'Success',
        'saveSuccess': 'QR Code was sent to the gallery',
        'error': 'Error',
        'errorMsg': 'Permission denied',
        //ResultQrReaderView
        'resultPage': 'QR Code Result',
        'clickToLaunch': 'Click to launch on browser',
        'clickCopy': 'Click to copy',
        'copied': 'Copied',
        'copiedMsg': 'Data has been copied to clipboard',
      });
  }
}
