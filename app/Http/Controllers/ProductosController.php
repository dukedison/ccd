<?php

namespace App\Http\Controllers;

use App\Productos;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ProductosController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
        $datos['productos']=Productos::paginate(5);
        return view('productos.index',$datos);
        
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
        return view('productos.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //

        //$datosProductos=request()->all();

        $datosProductos=request()->except('_token');

        if($request->hasFile('Foto')){

            $datosProductos['Foto']=$request->file('Foto')->store('uploads','public');
        }

        Productos::insert($datosProductos);

        //return response()->json($datosProductos);
        return redirect('productos')->with('Mensaje','Producto registrado correctamente');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Productos  $productos
     * @return \Illuminate\Http\Response
     */
    public function show(Productos $productos)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Productos  $productos
     * @return \Illuminate\Http\Response
     */
    public function edit($idProducto)
    {
        //

        $producto = Productos::findOrFail($idProducto);

        return view('productos.edit',compact('producto'));
        //return redirect('productos');
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Productos  $productos
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $idProducto)
    {
        //

        $datosProductos=request()->except(['_token','_method']);

        if($request->hasFile('Foto')){

            $producto = Productos::findOrFail($idProducto);

            Storage::delete('public/'.$producto->foto);

            $datosProductos['Foto']=$request->file('Foto')->store('uploads','public');
        }

        Productos::where('idProducto','=',$idProducto)->update($datosProductos);

        //$producto = Productos::findOrFail($idProducto);
        //return view('productos.edit',compact('producto'));

        return redirect('productos')->with('Mensaje','Producto modificado correctamente');

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Productos  $productos
     * @return \Illuminate\Http\Response
     */
    public function destroy($idProducto)

    {
        //

        $producto = Productos::findOrFail($idProducto);

        if (Storage::delete('public/'.$producto->foto)){

            Productos::destroy($idProducto);

        }

        return redirect('productos')->with('Mensaje','Producto eliminado correctamente');
    }
}
